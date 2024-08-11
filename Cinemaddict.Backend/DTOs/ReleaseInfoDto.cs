using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.DTOs
{
    public class ReleaseInfoDto
    {
        public ReleaseInfoDto(ReleaseInfo releaseInfo)
        {
            release_country = releaseInfo.Country;
            date = releaseInfo.Date;
        }

        public string release_country { get; }
        public DateTime date { get; }
    }
}
