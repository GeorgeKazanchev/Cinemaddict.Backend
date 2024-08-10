namespace Cinemaddict.Backend.Errors
{
    public class NotFoundError : Error
    {
        public NotFoundError() : base("404", "Not found") { }
    }
}
