namespace Cinemaddict.Domain.Entities
{
    public class LocalComment
    {
        public LocalComment(string content, DateTime date)  //  TODO: Add CommentEmotion
        {
            Content = content;
            Date = date;
        }

        public string Content { get; }
        public DateTime Date { get; }
    }
}
