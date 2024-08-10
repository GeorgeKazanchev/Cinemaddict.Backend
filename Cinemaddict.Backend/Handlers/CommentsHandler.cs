using Cinemaddict.DatabaseAccess.Repository;

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
                if (filmExists)
                {
                    var comments = _repository.ReadComments(id);
                    response.StatusCode = 200;
                    await response.WriteAsJsonAsync(comments);
                }
                else
                {
                    ErrorsHandler.HandleNotFound(response);
                }
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }

        public async Task CreateComment(string? filmId, HttpRequest request, HttpResponse response)
        {
            throw new NotImplementedException();
        }

        public async Task DeleteComment(string? commentId, HttpResponse response)
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
                if (commentExists)
                {
                    _repository.DeleteComment(id);
                    response.StatusCode = 200;
                    //  TODO: Don't we need to write anything to response?
                }
                else
                {
                    ErrorsHandler.HandleNotFound(response);
                }
            }
            catch (Exception)
            {
                ErrorsHandler.HandleInternalServerError(response);
            }
        }
    }
}
