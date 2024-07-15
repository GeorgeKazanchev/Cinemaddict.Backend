namespace Cinemaddict.Domain.Entities
{
    public class Comment : LocalComment
    {
        public Comment(int id, string author, string content, DateTime date, string emotion)
            : base(content, date, emotion)
        {
            Id = id;
            Author = author;
        }

        public int Id { get; }
        public string Author { get; }
    }
}
