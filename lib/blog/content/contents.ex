defmodule Blog.Content.Contents do
  alias Blog.Repo
  alias Blog.Content.Comment
  alias Blog.Content.Post
  alias Ecto.Changeset

  @type create_post_attrs :: %{user_id: integer, message: String.t()}

  @spec create_post(create_post_attrs) :: {:ok, Post.t()} | {:error, Changeset.t()}
  def create_post(attrs) do
    attrs
    |> Post.create_changeset()
    |> Repo.insert()
  end

  @spec create_comment(Post.t(), String.t()) :: {:ok, Post.t()} | {:error, Changeset.t()}
  def create_comment(post, message) do
    insert_comment(post.id, nil, message)
  end

  @spec create_reply(Post.t(), Comment.t(), String.t()) ::
          {:ok, Post.t()} | {:error, Changeset.t()}
  def create_reply(post, comment, message) do
    insert_comment(post.id, comment.id, message)
  end

  defp insert_comment(post_id, comment_id, message) do
    %{}
    |> Map.put(:post_id, post_id)
    |> Map.put(:comment_id, comment_id)
    |> Map.put(:message, message)
    |> Comment.create_changeset()
    |> Repo.insert()
  end
end
