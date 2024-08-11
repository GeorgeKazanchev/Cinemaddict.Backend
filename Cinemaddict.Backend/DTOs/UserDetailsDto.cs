using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.DTOs
{
    public class UserDetailsDto
    {
        public UserDetailsDto(UserDetails userDetails)
        {
            watchlist = userDetails.IsInWatchlist;
            already_watched = userDetails.IsWatched;
            favorite = userDetails.IsFavorite;
            watching_date = userDetails.WatchingDate;
        }

        public bool watchlist { get; }
        public bool already_watched { get; }
        public bool favorite { get; }
        public DateTime? watching_date { get; }
    }
}
