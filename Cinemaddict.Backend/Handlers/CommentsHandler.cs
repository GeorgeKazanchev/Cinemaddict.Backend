using Cinemaddict.Backend.DTOs;
using Cinemaddict.DatabaseAccess.Repository;
using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.Handlers
{
    public class CommentsHandler
    {
        public CommentsHandler(IDbRepository repository)
        {
            _repository = repository;
        }

        private readonly IDbRepository _repository;

        public async Task ReadComments(string? filmId, HttpResponse response)
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

                var comments = _repository.ReadComments(id);
                await response.WriteAsJsonAsync(comments.Select(c => new CommentDto(c)));
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }

        public async Task CreateComment(string? filmId, HttpRequest request, HttpResponse response)
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

                var commentDto = await request.ReadFromJsonAsync<LocalCommentDto>()
                    ?? throw new Exception("Failed to get comment\'s data from a request.");
                var comment = commentDto.ToDomain();

                var authorName = _repository.GetRandomUserName();
                _repository.CreateComment(comment, id, authorName);

                var movie = _repository.ReadMovie(id);
                var comments = _repository.ReadComments(id);
                await response.WriteAsJsonAsync(new
                {
                    movie = new MovieDto(movie),
                    comments = comments.Select(c => new CommentDto(c))
                });
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }

        public void DeleteComment(string? commentId, HttpResponse response)
        {
            bool isIdCorrect = int.TryParse(commentId, out int id);
            if (!isIdCorrect)
            {
                ErrorsHandler.HandleNotFound(response);
                return;
            }

            try
            {
                bool commentExists = _repository.CheckCommentExists(id);
                if (!commentExists)
                {
                    ErrorsHandler.HandleNotFound(response);
                    return;
                }

                _repository.DeleteComment(id);  //  TODO: Don't we need to write anything to response?
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }
    }
}
