defmodule Blog.Content.Queries do
  import Ecto.Query, only: [from: 2]

  alias Blog.Content.Comment
  alias Blog.Content.Post
  alias Blog.Content.Like

  def get_post(id) do
    comments_query = from c in Comment, where: c.reply == false

    from p in Post,
      where: p.id == ^id,
      preload: [comments: ^comments_query]
  end

  def exists_query(comment_id, user_id) do
    from l in Like, where: l.comment_id == ^comment_id and l.user_id == ^user_id
  end

  def count_likes(comment_id) do
    from l in Like, where: l.comment_id == ^comment_id, select: count(l.id)
  end
end
