defmodule Blog.Content.Queries do
  import Ecto.Query, only: [from: 2]

  alias Blog.Content.Comment
  alias Blog.Content.Post

  def get_post(id) do
    comments_query = from c in Comment, where: is_nil(c.comment_id)

    from p in Post,
      where: p.id == ^id,
      preload: [comments: ^comments_query]
  end
end
