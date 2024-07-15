using System;
using System.Collections.Generic;

namespace Cinemaddict.DatabaseAccess.Entities;

public partial class Comment
{
    public int Id { get; set; }

    public string Content { get; set; } = null!;

    public DateTime Date { get; set; }

    public int IdFilm { get; set; }

    public int IdAuthor { get; set; }

    public virtual User IdAuthorNavigation { get; set; } = null!;

    public virtual Film IdFilmNavigation { get; set; } = null!;
}
