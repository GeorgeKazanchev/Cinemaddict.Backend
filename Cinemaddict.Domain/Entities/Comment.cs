namespace Cinemaddict.Domain.Entities
{
    public class Comment : LocalComment
    {
        public Comment(int id, string author, string content, DateTime date)
            : base(content, date)
        {
            Id = id;
            Author = author;
        }

        public int Id { get; }
        public string Author { get; }
    }
}
