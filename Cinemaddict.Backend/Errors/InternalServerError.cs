namespace Cinemaddict.Backend.Errors
{
    public class InternalServerError : Error
    {
        public InternalServerError() : base("500", "Internal Server Error") { }
    }
}
