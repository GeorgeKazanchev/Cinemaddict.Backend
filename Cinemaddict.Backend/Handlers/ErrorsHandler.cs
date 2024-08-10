using Cinemaddict.Backend.Errors;

namespace Cinemaddict.Backend.Handlers
{
    public static class ErrorsHandler
    {
        public async static void HandleBadRequest(HttpResponse response)
        {
            response.StatusCode = 400;
            await response.WriteAsJsonAsync(new BadRequestError());
        }

        public async static void HandleAuthorizationError(HttpResponse response)
        {
            response.StatusCode = 401;
            await response.WriteAsJsonAsync(new AuthorizationError());
        }

        public async static void HandleNotFound(HttpResponse response)
        {
            response.StatusCode = 404;
            await response.WriteAsJsonAsync(new NotFoundError());
        }

        public async static void HandleInternalServerError(HttpResponse response)
        {
            response.StatusCode = 500;
            await response.WriteAsJsonAsync(new InternalServerError());
        }
    }
}
