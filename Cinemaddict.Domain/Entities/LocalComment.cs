namespace Cinemaddict.Domain.Entities
{
    public class LocalComment
    {
        public LocalComment(string content, DateTime date, string emotion)
        {
            Content = content;
            Date = date;
            Emotion = emotion;
        }

        public string Content { get; }
        public DateTime Date { get; }
        public string Emotion { get; }
    }
}
