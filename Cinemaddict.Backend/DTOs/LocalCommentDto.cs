using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.DTOs
{
    public class LocalCommentDto
    {
        public LocalCommentDto(string comment, DateTime date, string emotion)
        {
            this.comment = comment;
            this.date = date;
            this.emotion = emotion;
        }

        public string comment { get; }
        public DateTime date { get; }
        public string emotion { get; }

        public LocalComment ToDomain()
        {
            return new LocalComment(comment, date, emotion);
        }
    }
}
