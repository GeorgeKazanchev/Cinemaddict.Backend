namespace Cinemaddict.Backend.Errors
{
    public abstract class Error
    {
        protected Error(string error, string message)
        {
            this.error = error;
            this.message = message;
        }

        public readonly string error;
        public readonly string message;
    }
}
