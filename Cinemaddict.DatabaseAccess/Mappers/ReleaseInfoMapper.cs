using ReleaseInfoDomain = Cinemaddict.Domain.Entities.ReleaseInfo;
using ReleaseInfoEntity = Cinemaddict.DatabaseAccess.Entities.ReleaseInfo;

namespace Cinemaddict.DatabaseAccess.Mappers
{
    public static class ReleaseInfoMapper
    {
        public static ReleaseInfoDomain ToDomain(ReleaseInfoEntity releaseInfo)
        {
            return new ReleaseInfoDomain(releaseInfo.ReleaseCountry, releaseInfo.Date);
        }
    }
}
