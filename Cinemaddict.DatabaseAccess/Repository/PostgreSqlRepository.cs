using Cinemaddict.DatabaseAccess.Entities;
using Cinemaddict.DatabaseAccess.Mappers;
using Cinemaddict.Domain.Entities;
using Comment = Cinemaddict.Domain.Entities.Comment;
using CommentEntity = Cinemaddict.DatabaseAccess.Entities.Comment;
using ReleaseInfoEntity = Cinemaddict.DatabaseAccess.Entities.ReleaseInfo;
using UserEntity = Cinemaddict.DatabaseAccess.Entities.User;

namespace Cinemaddict.DatabaseAccess.Repository
{
    public class PostgreSqlRepository : IDbRepository
    {
        public PostgreSqlRepository(string connectionString)
        {
            ConnectionString = connectionString;
        }

        public string ConnectionString { get; }

        private const string UserName = "Frank Sinatra";    //  UserName is hard-coded in the client app and can't be changed

        public Movie[] ReadMovies()
        {
            using var db = new CinemaddictContext(ConnectionString);

            var films = db.Films.ToArray();
            var filmsDomain = new Movie[films.Length];

            for (int i = 0; i < films.Length; ++i)
            {
                var film = films[i];

                var userId = GetUserId(UserName);
                ReadMovieAssosiatedData(db, film, userId, out var genres, out var actors, out var writers, out var comments,
                    out var director, out var userDetails, out var releaseInfo);

                if (director == null) continue;
                if (userDetails == null) continue;
                if (releaseInfo == null) continue;

                filmsDomain[i] = FilmMapper.ToDomain(film, comments, userDetails, genres, actors, writers, director, releaseInfo);
            }

            return filmsDomain;
        }

        public Movie ReadMovie(int id)
        {
            using var db = new CinemaddictContext(ConnectionString);

            var film = db.Films.FirstOrDefault(f => f.Id == id)
                ?? throw new Exception("Given film is not found in a database.");

            var userId = GetUserId(UserName);
            ReadMovieAssosiatedData(db, film, userId, out var genres, out var actors, out var writers, out var comments,
                    out var director, out var userDetails, out var releaseInfo);

            if (director == null) throw new Exception("A director of a given film is not found in a database.");
            if (userDetails == null) throw new Exception("User details of a given film is not found in a database.");
            if (releaseInfo == null) throw new Exception("Release info of a given film is not found in a database.");

            return FilmMapper.ToDomain(film, comments, userDetails, genres, actors, writers, director, releaseInfo);
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
                if (author == null)
                {
                    author = new UserEntity
                    {
                        Name = authorName
                    };
                    db.Users.Add(author);
                    db.SaveChanges();
                }

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
                db.SaveChanges();
            }
        }

        public int GetUserId(string userName)
        {
            using var db = new CinemaddictContext(ConnectionString);
            var user = db.Users.FirstOrDefault(u => u.Name == userName) ?? throw new Exception("Given user is not found in a database.");
            return user.Id;
        }

        public string GetRandomUserName()
        {
            using var db = new CinemaddictContext(ConnectionString);
            var users = db.Users.ToArray();
            var randomGenerator = new Random();
            var randomUserIndex = randomGenerator.Next(users.Length);
            return users[randomUserIndex].Name;
        }

        public bool CheckMovieExists(int id)
        {
            using var db = new CinemaddictContext(ConnectionString);
            return db.Films.Any(f => f.Id == id);
        }

        public bool CheckCommentExists(int id)
        {
            using var db = new CinemaddictContext(ConnectionString);
            return db.Comments.Any(c => c.Id == id);
        }

        private static void ReadMovieAssosiatedData(CinemaddictContext db, Film film, int userId, out Genre[] genres,
            out Actor[] actors, out Writer[] writers, out CommentEntity[] comments, out Director? director,
            out UserDetail? userDetails, out ReleaseInfoEntity? releaseInfo)
        {
            genres = db.Genres.Where(g => g.IdFilms.Any(f => f.Id == film.Id)).ToArray();
            actors = db.Actors.Where(a => a.IdFilms.Any(f => f.Id == film.Id)).ToArray();
            writers = db.Writers.Where(w => w.IdFilms.Any(f => f.Id == film.Id)).ToArray();
            comments = db.Comments.Where(c => c.IdFilm == film.Id).ToArray();

            director = db.Directors.FirstOrDefault(d => d.Id == film.IdDirector);
            userDetails = db.UserDetails.FirstOrDefault(ud => ud.IdFilm == film.Id && ud.IdUser == userId);
            releaseInfo = db.ReleaseInfos.FirstOrDefault(i => i.Id == film.IdReleaseInfo);
        }
    }
}
