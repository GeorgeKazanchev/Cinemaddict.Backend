using FilmDomain = Cinemaddict.Domain.Entities.Movie;
using FilmEntity = Cinemaddict.DatabaseAccess.Entities.Film;
using FilmInfoDomain = Cinemaddict.Domain.Entities.FilmInfo;
using CommentEntity = Cinemaddict.DatabaseAccess.Entities.Comment;
using UserDetailsEntity = Cinemaddict.DatabaseAccess.Entities.UserDetail;
using GenreEntity = Cinemaddict.DatabaseAccess.Entities.Genre;
using ActorEntity = Cinemaddict.DatabaseAccess.Entities.Actor;
using WriterEntity = Cinemaddict.DatabaseAccess.Entities.Writer;
using DirectorEntity = Cinemaddict.DatabaseAccess.Entities.Director;
using ReleaseInfoEntity = Cinemaddict.DatabaseAccess.Entities.ReleaseInfo;

namespace Cinemaddict.DatabaseAccess.Mappers
{
    public static class FilmMapper
    {
        public static FilmDomain ToDomain(FilmEntity film, CommentEntity[] comments, UserDetailsEntity userDetails,
            GenreEntity[] genres, ActorEntity[] actors, WriterEntity[] writers, DirectorEntity director, ReleaseInfoEntity releaseInfo)
        {
            var commentsId = comments.Select(c => c.Id).ToArray();
            var userDetailsDomain = UserDetailsMapper.ToDomain(userDetails);
            var releaseInfoDomain = ReleaseInfoMapper.ToDomain(releaseInfo);
            var genresNames = genres.Select(g => g.Name).ToArray();
            var actorsNames = actors.Select(a => a.Name).ToArray();
            var writersNames = writers.Select(w => w.Name).ToArray();
            var directorName = director.Name;

            var filmInfoDomain = new FilmInfoDomain(film.Title, film.AlternativeTitle, film.TotalRating, film.Poster,
                film.AgeRating, film.Runtime, film.Description, directorName, genresNames, writersNames, actorsNames, releaseInfoDomain);

            return new FilmDomain(film.Id, commentsId, filmInfoDomain, userDetailsDomain);
        }
    }
}
