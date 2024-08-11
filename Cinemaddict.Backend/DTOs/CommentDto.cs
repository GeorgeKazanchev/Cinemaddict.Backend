using Cinemaddict.Domain.Entities;

namespace Cinemaddict.Backend.DTOs
{
    public class CommentDto
    {
        public CommentDto(Comment comment)
        {
            id = comment.Id.ToString();
            author = comment.Author;
            date = comment.Date;
            emotion = comment.Emotion;
            this.comment = comment.Content;
        }

        public string id { get; }
        public string author { get; }
        public string comment { get; }
        public DateTime date { get; }
        public string emotion { get; }
    }
}
