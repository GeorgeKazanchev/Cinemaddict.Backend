using UserDetailsDomain = Cinemaddict.Domain.Entities.UserDetails;
using UserDetailsEntity = Cinemaddict.DatabaseAccess.Entities.UserDetail;

namespace Cinemaddict.DatabaseAccess.Mappers
{
    public static class UserDetailsMapper
    {
        public static UserDetailsDomain ToDomain(UserDetailsEntity userDetails)
        {
            return new UserDetailsDomain(userDetails.IsInWatchlist, userDetails.IsWatched, userDetails.IsFavorite, userDetails.WatchingDate);
        }
    }
}
