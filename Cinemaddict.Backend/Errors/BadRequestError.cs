namespace Cinemaddict.Backend.Errors
{
    public class BadRequestError : Error
    {
        public BadRequestError() : base("400", "Bad Request") { }
    }
}
