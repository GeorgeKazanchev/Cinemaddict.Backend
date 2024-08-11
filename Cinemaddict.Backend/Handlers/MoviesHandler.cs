using Cinemaddict.Backend.DTOs;
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
                await response.WriteAsJsonAsync(movies.Select(m => new MovieDto(m)));
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
