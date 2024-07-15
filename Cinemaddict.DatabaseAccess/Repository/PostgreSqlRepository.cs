using Cinemaddict.Domain.Entities;

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
            var filmsEntity = db.Comments.ToArray();
            /*var filmsDomain = filmsEntity.Select(f => new Movie(f.Id, ));*/

            throw new NotImplementedException();
        }

        public void UpdateMovie(Movie movie)
        {
            using var db = new CinemaddictContext(ConnectionString);

            throw new NotImplementedException();
        }

        public Comment[] ReadComments(int filmId)
        {
            /*using var db = new CinemaddictContext(ConnectionString);
            var commentsEntity = db.Comments.Where(c => c.IdFilm == filmId).ToArray();
            var commentsDomain = commentsEntity.Select(c => new Comment(c.Id, c.IdAuthorNavigation.Name, c.Date));*/
            throw new NotImplementedException();
        }

        public void CreateComment(LocalComment comment)
        {
            using var db = new CinemaddictContext(ConnectionString);

            throw new NotImplementedException();
        }

        public void DeleteComment(int id)
        {
            using var db = new CinemaddictContext(ConnectionString);

            throw new NotImplementedException();
        }
    }
}
