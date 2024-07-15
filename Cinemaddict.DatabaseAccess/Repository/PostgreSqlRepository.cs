using Cinemaddict.DatabaseAccess.Mappers;
using Cinemaddict.Domain.Entities;
using Comment = Cinemaddict.Domain.Entities.Comment;
using CommentEntity = Cinemaddict.DatabaseAccess.Entities.Comment;
using UserEntity = Cinemaddict.DatabaseAccess.Entities.User;

namespace Cinemaddict.DatabaseAccess.Repository
{
    public class PostgreSqlRepository
    {
        public PostgreSqlRepository(string connectionString)
        {
            ConnectionString = connectionString;
        }

        public string ConnectionString { get; }

        public Movie[] ReadMovies()
        {
            using var db = new CinemaddictContext(ConnectionString);

            var films = db.Films.ToArray();
            var filmsDomain = new Movie[films.Length];

            for (int i = 0; i < films.Length; ++i)
            {
                var film = films[i];

                var genres = db.Genres.Where(g => g.IdFilms.Any(f => f.Id == film.Id)).ToArray();
                var actors = db.Actors.Where(a => a.IdFilms.Any(f => f.Id == film.Id)).ToArray();
                var writers = db.Writers.Where(w => w.IdFilms.Any(f => f.Id == film.Id)).ToArray();
                var comments = db.Comments.Where(c => c.IdFilm == film.Id).ToArray();

                var director = db.Directors.FirstOrDefault(d => d.Id == film.IdDirector);
                var userDetails = db.UserDetails.FirstOrDefault(u => u.IdFilm == film.Id);
                var releaseInfo = db.ReleaseInfos.FirstOrDefault(i => i.Id == film.IdReleaseInfo);

                if (director == null) continue;
                if (userDetails == null) continue;
                if (releaseInfo == null) continue;

                filmsDomain[i] = FilmMapper.ToDomain(film, comments, userDetails, genres, actors, writers, director, releaseInfo);
            }

            return filmsDomain;
        }

        public void UpdateMovie(Movie movie)
        {
            using var db = new CinemaddictContext(ConnectionString);

            var movieEntity = db.Films.FirstOrDefault(m => m.Id == movie.Id) ?? throw new Exception("Film is not found in a database.");
            var userDetails = db.UserDetails.FirstOrDefault(u => u.IdFilm == movie.Id) ?? throw new Exception("User details not found in a database.");

            userDetails.IsInWatchlist = movie.UserDetails.IsInWatchlist;
            userDetails.IsWatched = movie.UserDetails.IsWatched;
            userDetails.IsFavorite = movie.UserDetails.IsFavorite;
            userDetails.WatchingDate = movie.UserDetails.WatchingDate;

            db.Update(userDetails);
            db.SaveChanges();
        }

        public Comment[] ReadComments(int filmId)
        {
            using var db = new CinemaddictContext(ConnectionString);

            var comments = db.Comments.Where(c => c.IdFilm == filmId).ToArray();
            var commentsDomain = new Comment[comments.Length];

            for (int i = 0; i < comments.Length; ++i)
            {
                var comment = comments[i];

                var author = db.Users.FirstOrDefault(u => u.Id == comment.IdAuthor);
                var emotion = db.Emotions.FirstOrDefault(e => e.Id == comment.IdEmotion);

                if (author == null) continue;
                if (emotion == null) continue;

                commentsDomain[i] = CommentMapper.ToDomain(comment, author, emotion);
            }

            return commentsDomain;
        }

        public void CreateComment(LocalComment comment, int filmId, string authorName)
        {
            using var db = new CinemaddictContext(ConnectionString);
            using var transaction = db.Database.BeginTransaction();

            try
            {
                var author = db.Users.FirstOrDefault(u => u.Name == authorName);
                author ??= new UserEntity
                {
                    Name = authorName
                };
                db.Users.Add(author);
                db.SaveChanges();

                var emotion = db.Emotions.FirstOrDefault(e => e.Name == comment.Emotion)
                    ?? throw new Exception("Given emotion is not found in a database.");

                var commentEntity = new CommentEntity
                {
                    Content = comment.Content,
                    Date = comment.Date,
                    IdFilm = filmId,
                    IdAuthor = author.Id,
                    IdEmotion = emotion.Id
                };
                db.Add(commentEntity);
                db.SaveChanges();

                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
            }
        }

        public void DeleteComment(int id)
        {
            using var db = new CinemaddictContext(ConnectionString);
            var comment = db.Comments.FirstOrDefault(c => c.Id == id);
            if (comment != null)
            {
                db.Comments.Remove(comment);
            }
            db.SaveChanges();
        }
    }
}
