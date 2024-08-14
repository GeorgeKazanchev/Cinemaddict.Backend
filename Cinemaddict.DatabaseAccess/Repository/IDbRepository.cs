using Cinemaddict.Domain.Entities;

namespace Cinemaddict.DatabaseAccess.Repository
{
    public interface IDbRepository
    {
        public string ConnectionString { get; }

        public Movie[] ReadMovies();
        public Movie ReadMovie(int id);
        public void UpdateMovie(Movie movie);
        public Comment[] ReadComments(int filmId);
        public void CreateComment(LocalComment comment, int filmId, string authorName);
        public void DeleteComment(int id);
        public int GetUserId(string userName);
        public string GetRandomUserName();
        public bool CheckMovieExists(int id);
        public bool CheckCommentExists(int id);
    }
}
