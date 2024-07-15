using System;
using System.Collections.Generic;

namespace Cinemaddict.DatabaseAccess.Entities;

public partial class UserDetail
{
    public int IdUser { get; set; }

    public int IdFilm { get; set; }

    public bool IsFavorite { get; set; }

    public bool IsInWatchlist { get; set; }

    public bool IsWatched { get; set; }

    public DateTime? WatchingDate { get; set; }

    public virtual Film IdFilmNavigation { get; set; } = null!;

    public virtual User IdUserNavigation { get; set; } = null!;
}
