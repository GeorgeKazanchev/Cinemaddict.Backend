using System;
using System.Collections.Generic;

namespace Cinemaddict.DatabaseAccess.Entities;

public partial class ReleaseInfo
{
    public int Id { get; set; }

    public DateTime Date { get; set; }

    public string ReleaseCountry { get; set; } = null!;

    public virtual ICollection<Film> Films { get; set; } = new List<Film>();
}
