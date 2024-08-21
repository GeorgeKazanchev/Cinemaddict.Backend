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

        public Movie ToDomain()
        {
            var commentsIds = comments.Select(c => Convert.ToInt32(c)).ToArray();
            return new Movie(Convert.ToInt32(id), commentsIds, film_info.ToDomain(), user_details.ToDomain());
        }
    }
}
