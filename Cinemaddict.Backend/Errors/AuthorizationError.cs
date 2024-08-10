namespace Cinemaddict.Backend.Errors
{
    public class AuthorizationError : Error
    {
        public AuthorizationError() : base("401", "Header Authorization is not correct") { }
    }
}
