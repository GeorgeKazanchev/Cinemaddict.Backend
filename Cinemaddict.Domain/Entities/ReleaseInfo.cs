namespace Cinemaddict.Domain.Entities
{
    public class ReleaseInfo
    {
        public ReleaseInfo(string country, DateTime date)
        {
            Country = country;
            Date = date;
        }

        public string Country { get; }
        public DateTime Date { get; }
    }
}
