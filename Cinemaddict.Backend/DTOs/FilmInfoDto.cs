using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.DTOs
{
    public class FilmInfoDto
    {
        public FilmInfoDto(FilmInfo filmInfo)
        {
            title = filmInfo.Title;
            alternative_title = filmInfo.AlternativeTitle;
            total_rating = filmInfo.TotalRating;
            poster = filmInfo.PosterSrc;
            age_rating = filmInfo.AgeRating;
            runtime = filmInfo.RuntimeInMinutes;
            description = filmInfo.Description;
            director = filmInfo.Director;
            genre = filmInfo.Genres;
            writers = filmInfo.Writers;
            actors = filmInfo.Actors;
            release = new ReleaseInfoDto(filmInfo.ReleaseInfo);
        }

        public string title { get; }
        public string alternative_title { get; }
        public decimal total_rating { get; }
        public string poster { get; }
        public int age_rating { get; }
        public int runtime { get; }
        public string description { get; }
        public string director { get; }
        public string[] genre { get; }
        public string[] writers { get; }
        public string[] actors { get; }
        public ReleaseInfoDto release { get; }

        public FilmInfo ToDomain()
        {
            return new FilmInfo(title, alternative_title, total_rating, poster, age_rating, runtime,
                description, director, genre, writers, actors, release.ToDomain());
        }
    }
}
