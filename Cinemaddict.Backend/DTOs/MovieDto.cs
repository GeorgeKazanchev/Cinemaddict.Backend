using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.DTOs
{
    public class MovieDto
    {
        public MovieDto(Movie movie)
        {
            id = movie.Id.ToString();
            comments = movie.CommentsId.Select(c => c.ToString()).ToArray();
            film_info = new FilmInfoDto(movie.FilmInfo);
            user_details = new UserDetailsDto(movie.UserDetails);
        }

        public string id { get; }
        public string[] comments { get; }
        public FilmInfoDto film_info { get; }
        public UserDetailsDto user_details { get; }
    }
}
