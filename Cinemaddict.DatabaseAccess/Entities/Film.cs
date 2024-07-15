using System;
using System.Collections.Generic;

namespace Cinemaddict.DatabaseAccess.Entities;

public partial class Film
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public string AlternativeTitle { get; set; } = null!;

    public string Poster { get; set; } = null!;

    public string Description { get; set; } = null!;

    public decimal TotalRating { get; set; }

    public short AgeRating { get; set; }

    public short Runtime { get; set; }

    public int IdDirector { get; set; }

    public int IdReleaseInfo { get; set; }

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual Director IdDirectorNavigation { get; set; } = null!;

    public virtual ReleaseInfo IdReleaseInfoNavigation { get; set; } = null!;

    public virtual ICollection<UserDetail> UserDetails { get; set; } = new List<UserDetail>();

    public virtual ICollection<Actor> IdActors { get; set; } = new List<Actor>();

    public virtual ICollection<Genre> IdGenres { get; set; } = new List<Genre>();

    public virtual ICollection<Writer> IdWriters { get; set; } = new List<Writer>();
}
