using System;
using System.Collections.Generic;

namespace Cinemaddict.DatabaseAccess.Entities;

public partial class User
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<UserDetail> UserDetails { get; set; } = new List<UserDetail>();
}
