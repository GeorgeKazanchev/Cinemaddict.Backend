using System;
using System.Collections.Generic;

namespace Cinemaddict.DatabaseAccess.Entities;

public partial class Actor
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Film> IdFilms { get; set; } = new List<Film>();
}
