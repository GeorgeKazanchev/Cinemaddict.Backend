namespace Cinemaddict.Domain.Entities
{
    public class UserDetails
    {
        public UserDetails(bool isInWatchlist, bool isWatched, bool isFavorite, DateTime? watchingDate = null)
        {
            IsInWatchlist = isInWatchlist;
            IsWatched = isWatched;
            IsFavorite = isFavorite;
            WatchingDate = watchingDate;
        }

        public bool IsInWatchlist { get; }
        public bool IsWatched { get; }
        public bool IsFavorite { get; }
        public DateTime? WatchingDate { get; }
    }
}
