using Cinemaddict.DatabaseAccess.Repository;

namespace Cinemaddict.Backend.Handlers
{
    public class MoviesHandler
    {
        public MoviesHandler(IDbRepository repository)
        {
            _repository = repository;
        }

        private readonly IDbRepository _repository;

        public async Task ReadAllMovies(HttpResponse response)
        {
            try
            {
                var movies = _repository.ReadMovies();
                response.StatusCode = 200;
                await response.WriteAsJsonAsync(movies);
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }

        public async Task UpdateMovie(string? filmId, HttpRequest request, HttpResponse response)
        {
            throw new NotImplementedException();
        }
    }
}
