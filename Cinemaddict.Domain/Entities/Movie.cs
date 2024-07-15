namespace Cinemaddict.Domain.Entities
{
    public class Movie
    {
        public Movie(int id, int[] commentsId, FilmInfo filmInfo, UserDetails userDetails)
        {
            Id = id;
            CommentsId = commentsId;
            FilmInfo = filmInfo;
            UserDetails = userDetails;
        }

        public int Id { get; }
        public int[] CommentsId { get; }
        public FilmInfo FilmInfo { get; }
        public UserDetails UserDetails { get; }
    }
}
