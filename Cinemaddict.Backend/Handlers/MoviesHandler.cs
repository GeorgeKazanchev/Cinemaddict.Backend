using Cinemaddict.Backend.DTOs;
using Cinemaddict.DatabaseAccess.Repository;
using Cinemaddict.Domain.Entities;

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
            bool isIdCorrect = int.TryParse(filmId, out int id);
            if (!isIdCorrect)
            {
                ErrorsHandler.HandleNotFound(response);
                return;
            }

            try
            {
                bool filmExists = _repository.CheckMovieExists(id);
                if (!filmExists)
                {
                    ErrorsHandler.HandleNotFound(response);
                    return;
                }

                var updatedFilm = await request.ReadFromJsonAsync<Movie>() 
                    ?? throw new Exception("Failed to get film\'s data from a request.");

                _repository.UpdateMovie(updatedFilm);
                var film = _repository.ReadMovie(id);
                await response.WriteAsJsonAsync(new MovieDto(film));
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }
    }
}
