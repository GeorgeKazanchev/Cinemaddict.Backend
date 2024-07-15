using CommentDomain = Cinemaddict.Domain.Entities.Comment;
using CommentEntity = Cinemaddict.DatabaseAccess.Entities.Comment;
using UserEntity = Cinemaddict.DatabaseAccess.Entities.User;
using EmotionEntity = Cinemaddict.DatabaseAccess.Entities.Emotion;

namespace Cinemaddict.DatabaseAccess.Mappers
{
    public static class CommentMapper
    {
        public static CommentDomain ToDomain(CommentEntity comment, UserEntity author, EmotionEntity emotion)
        {
            return new CommentDomain(comment.Id, author.Name, comment.Content, comment.Date, emotion.Name);
        }
    }
}
