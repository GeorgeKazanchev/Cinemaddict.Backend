namespace Cinemaddict.Domain.Entities
{
    public class FilmInfo
    {
        public FilmInfo(string title, string alternativeTitle, decimal totalRating, string posterSrc, int ageRating,
            int runtimeInMinutes, string description, string director, string[] genres, string[] writers, string[] actors,
            ReleaseInfo releaseInfo)
        {
            Title = title;
            AlternativeTitle = alternativeTitle;
            TotalRating = totalRating;
            PosterSrc = posterSrc;
            AgeRating = ageRating;
            RuntimeInMinutes = runtimeInMinutes;
            Description = description;
            Director = director;
            Genres = genres;
            Writers = writers;
            Actors = actors;
            ReleaseInfo = releaseInfo;
        }

        public string Title { get; }
        public string AlternativeTitle { get; }
        public decimal TotalRating { get; }
        public string PosterSrc { get; }
        public int AgeRating { get; }
        public int RuntimeInMinutes { get; }
        public string Description { get; }
        public string Director { get; }
        public string[] Genres { get; }
        public string[] Writers { get; }
        public string[] Actors { get; }
        public ReleaseInfo ReleaseInfo { get; }
    }
}
