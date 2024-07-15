using Cinemaddict.DatabaseAccess.Entities;
using Microsoft.EntityFrameworkCore;

namespace Cinemaddict.DatabaseAccess
{
    public partial class CinemaddictContext : DbContext
    {
        public CinemaddictContext()
        {
        }

        public CinemaddictContext(string connectionString)
        {
            ConnectionString = connectionString;
        }

        public CinemaddictContext(DbContextOptions<CinemaddictContext> options)
            : base(options)
        {
        }

        public string ConnectionString { get; }

        public virtual DbSet<Actor> Actors { get; set; }

        public virtual DbSet<Comment> Comments { get; set; }

        public virtual DbSet<Director> Directors { get; set; }

        public virtual DbSet<Emotion> Emotions { get; set; }

        public virtual DbSet<Film> Films { get; set; }

        public virtual DbSet<Genre> Genres { get; set; }

        public virtual DbSet<ReleaseInfo> ReleaseInfos { get; set; }

        public virtual DbSet<User> Users { get; set; }

        public virtual DbSet<UserDetail> UserDetails { get; set; }

        public virtual DbSet<Writer> Writers { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseNpgsql(ConnectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasPostgresEnum("comment_emotion", new[] { "Smile", "Sleeping", "Puke", "Angry" });

            modelBuilder.Entity<Actor>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("actor_pkey");

                entity.ToTable("actor");

                entity.HasIndex(e => e.Name, "actor_uk_name").IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Comment>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("comment_pkey");

                entity.ToTable("comment");

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Content).HasColumnName("content");
                entity.Property(e => e.Date).HasColumnName("date");
                entity.Property(e => e.IdAuthor).HasColumnName("id_author");
                entity.Property(e => e.IdEmotion).HasColumnName("id_emotion");
                entity.Property(e => e.IdFilm).HasColumnName("id_film");

                entity.HasOne(d => d.IdAuthorNavigation).WithMany(p => p.Comments)
                    .HasForeignKey(d => d.IdAuthor)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("comment_fk_author");

                entity.HasOne(d => d.IdEmotionNavigation).WithMany(p => p.Comments)
                    .HasForeignKey(d => d.IdEmotion)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("comment_fk_emotion");

                entity.HasOne(d => d.IdFilmNavigation).WithMany(p => p.Comments)
                    .HasForeignKey(d => d.IdFilm)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("comment_fk_film");
            });

            modelBuilder.Entity<Director>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("director_pkey");

                entity.ToTable("director");

                entity.HasIndex(e => e.Name, "director_uk_name").IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Emotion>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("emotion_pkey");

                entity.ToTable("emotion");

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Name)
                    .HasMaxLength(50)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Film>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("film_pkey");

                entity.ToTable("film");

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.AgeRating).HasColumnName("age_rating");
                entity.Property(e => e.AlternativeTitle)
                    .HasMaxLength(100)
                    .HasColumnName("alternative_title");
                entity.Property(e => e.Description).HasColumnName("description");
                entity.Property(e => e.IdDirector).HasColumnName("id_director");
                entity.Property(e => e.IdReleaseInfo).HasColumnName("id_release_info");
                entity.Property(e => e.Poster).HasColumnName("poster");
                entity.Property(e => e.Runtime).HasColumnName("runtime");
                entity.Property(e => e.Title)
                    .HasMaxLength(100)
                    .HasColumnName("title");
                entity.Property(e => e.TotalRating)
                    .HasPrecision(3, 1)
                    .HasColumnName("total_rating");

                entity.HasOne(d => d.IdDirectorNavigation).WithMany(p => p.Films)
                    .HasForeignKey(d => d.IdDirector)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("film_fk_director");

                entity.HasOne(d => d.IdReleaseInfoNavigation).WithMany(p => p.Films)
                    .HasForeignKey(d => d.IdReleaseInfo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("film_fk_release_info");

                entity.HasMany(d => d.IdActors).WithMany(p => p.IdFilms)
                    .UsingEntity<Dictionary<string, object>>(
                        "FilmActor",
                        r => r.HasOne<Actor>().WithMany()
                            .HasForeignKey("IdActor")
                            .OnDelete(DeleteBehavior.ClientSetNull)
                            .HasConstraintName("film_actor_fk_actor"),
                        l => l.HasOne<Film>().WithMany()
                            .HasForeignKey("IdFilm")
                            .OnDelete(DeleteBehavior.ClientSetNull)
                            .HasConstraintName("film_actor_fk_film"),
                        j =>
                        {
                            j.HasKey("IdFilm", "IdActor").HasName("film_actor_pkey");
                            j.ToTable("film_actor");
                            j.IndexerProperty<int>("IdFilm").HasColumnName("id_film");
                            j.IndexerProperty<int>("IdActor").HasColumnName("id_actor");
                        });

                entity.HasMany(d => d.IdGenres).WithMany(p => p.IdFilms)
                    .UsingEntity<Dictionary<string, object>>(
                        "FilmGenre",
                        r => r.HasOne<Genre>().WithMany()
                            .HasForeignKey("IdGenre")
                            .OnDelete(DeleteBehavior.ClientSetNull)
                            .HasConstraintName("film_genre_fk_genre"),
                        l => l.HasOne<Film>().WithMany()
                            .HasForeignKey("IdFilm")
                            .OnDelete(DeleteBehavior.ClientSetNull)
                            .HasConstraintName("film_genre_fk_film"),
                        j =>
                        {
                            j.HasKey("IdFilm", "IdGenre").HasName("film_genre_pkey");
                            j.ToTable("film_genre");
                            j.IndexerProperty<int>("IdFilm").HasColumnName("id_film");
                            j.IndexerProperty<int>("IdGenre").HasColumnName("id_genre");
                        });

                entity.HasMany(d => d.IdWriters).WithMany(p => p.IdFilms)
                    .UsingEntity<Dictionary<string, object>>(
                        "FilmWriter",
                        r => r.HasOne<Writer>().WithMany()
                            .HasForeignKey("IdWriter")
                            .OnDelete(DeleteBehavior.ClientSetNull)
                            .HasConstraintName("film_writer_fk_writer"),
                        l => l.HasOne<Film>().WithMany()
                            .HasForeignKey("IdFilm")
                            .OnDelete(DeleteBehavior.ClientSetNull)
                            .HasConstraintName("film_writer_fk_film"),
                        j =>
                        {
                            j.HasKey("IdFilm", "IdWriter").HasName("film_writer_pkey");
                            j.ToTable("film_writer");
                            j.IndexerProperty<int>("IdFilm").HasColumnName("id_film");
                            j.IndexerProperty<int>("IdWriter").HasColumnName("id_writer");
                        });
            });

            modelBuilder.Entity<Genre>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("genre_pkey");

                entity.ToTable("genre");

                entity.HasIndex(e => e.Name, "genre_uk_name").IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<ReleaseInfo>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("release_info_pkey");

                entity.ToTable("release_info");

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Date).HasColumnName("date");
                entity.Property(e => e.ReleaseCountry)
                    .HasMaxLength(50)
                    .HasColumnName("release_country");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("user_pkey");

                entity.ToTable("user");

                entity.HasIndex(e => e.Name, "user_uk_name").IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<UserDetail>(entity =>
            {
                entity.HasKey(e => new { e.IdUser, e.IdFilm }).HasName("user_details_pkey");

                entity.ToTable("user_details");

                entity.Property(e => e.IdUser).HasColumnName("id_user");
                entity.Property(e => e.IdFilm).HasColumnName("id_film");
                entity.Property(e => e.IsFavorite).HasColumnName("is_favorite");
                entity.Property(e => e.IsInWatchlist).HasColumnName("is_in_watchlist");
                entity.Property(e => e.IsWatched).HasColumnName("is_watched");
                entity.Property(e => e.WatchingDate).HasColumnName("watching_date");

                entity.HasOne(d => d.IdFilmNavigation).WithMany(p => p.UserDetails)
                    .HasForeignKey(d => d.IdFilm)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("user_details_fk_film");

                entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.UserDetails)
                    .HasForeignKey(d => d.IdUser)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("user_details_fk_user");
            });

            modelBuilder.Entity<Writer>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("writer_pkey");

                entity.ToTable("writer");

                entity.HasIndex(e => e.Name, "writer_uk_name").IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
