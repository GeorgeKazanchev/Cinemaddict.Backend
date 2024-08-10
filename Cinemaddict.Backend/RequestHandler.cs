using Cinemaddict.Backend.Handlers;
using Cinemaddict.DatabaseAccess.Repository;
using System.Text.RegularExpressions;

namespace Cinemaddict.Backend
{
    public partial class RequestHandler
    {
        public RequestHandler(IDbRepository repository)
        {
            _moviesHandler = new MoviesHandler(repository);
            _commentsHandler = new CommentsHandler(repository);
        }

        private readonly MoviesHandler _moviesHandler;
        private readonly CommentsHandler _commentsHandler;

        public async Task HandleRequest(HttpContext context)
        {
            var request = context.Request;
            var response = context.Response;
            var path = request.Path;

            var isAuthHeaderCorrect = CheckAuthorizationHeader(request.Headers);
            if (!isAuthHeaderCorrect)
            {
                ErrorsHandler.HandleAuthorizationError(response);
                return;
            }

            if (path == "/movies" && request.Method == "GET")
            {
                await _moviesHandler.ReadAllMovies(response);
            }
            else if (MoviesPathRegex().IsMatch(path) && request.Method == "PUT")
            {
                string? filmId = GetIdFromPath(path);
                await _moviesHandler.UpdateMovie(filmId, request, response);
            }
            else if (CommentsPathRegex().IsMatch(path) && request.Method == "GET")
            {
                string? filmId = GetIdFromPath(path);
                await _commentsHandler.ReadComments(filmId, response);
            }
            else if (CommentsPathRegex().IsMatch(path) && request.Method == "POST")
            {
                string? filmId = GetIdFromPath(path);
                await _commentsHandler.CreateComment(filmId, request, response);
            }
            else if (CommentsPathRegex().IsMatch(path) && request.Method == "DELETE")
            {
                string? commentId = GetIdFromPath(path);
                await _commentsHandler.DeleteComment(commentId, response);
            }
            else
            {
                ErrorsHandler.HandleBadRequest(response);
            }
        }

        private bool CheckAuthorizationHeader(IHeaderDictionary headers)
        {
            var authHeaderExists = headers.TryGetValue("Authorization", out var authHeader);

            if (!authHeaderExists)
            {
                return false;
            }

            return AuthHeaderRegex().IsMatch(authHeader);
        }

        private string? GetIdFromPath(PathString path)
        {
            return path.Value?.Split("/")[2];
        }

        [GeneratedRegex("^/movies/([0-9]+)$")]
        private static partial Regex MoviesPathRegex();

        [GeneratedRegex("^/comments/([0-9]+)$")]
        private static partial Regex CommentsPathRegex();

        [GeneratedRegex("^Basic ([0-9]|[a-zA-Z])+$")]
        private static partial Regex AuthHeaderRegex();
    }
}
