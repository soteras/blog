defmodule Blog.Content.Contents do
  alias Blog.Repo
  alias Blog.Content.Comment
  alias Blog.Content.Post
  alias Blog.Content.Queries
  alias Blog.Content.Like
  alias Ecto.Changeset

  @spec get_all_posts :: list(Post.t()) | []
  def get_all_posts() do
    Post
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @spec get_post(integer) :: Post.t() | nil
  def get_post(id) do
    id
    |> Queries.get_post()
    |> Repo.one()
  end

  @type create_post_attrs :: %{user_id: integer, message: String.t()}

  @spec create_post(create_post_attrs) :: {:ok, Post.t()} | {:error, Changeset.t()}
  def create_post(attrs) do
    attrs
    |> Post.create_changeset()
    |> Repo.insert()
  end

  @type create_comment_attrs :: %{
          post_id: integer,
          comment_id: integer,
          user_id: integer,
          message: String.t()
        }

  @spec create_comment(create_comment_attrs) :: {:ok, Comment.t()} | {:error, Changeset.t()}
  def create_comment(attrs) do
    attrs
    |> Comment.create_changeset()
    |> Repo.insert()
  end

  @spec update_comment(Comment.t(), String.t()) :: {:ok, Comment.t()} | {:error, Changeset.t()}
  def update_comment(comment, message) do
    comment
    |> Comment.update_changeset(Map.put(%{}, :message, message))
    |> Repo.update()
  end

  @spec count_likes(Comment.t()) :: integer
  def count_likes(comment) do
    comment
    |> Map.get(:id)
    |> Queries.count_likes()
    |> Repo.one()
  end

  @spec like_exists?(Comment.t(), User.t()) :: boolean
  def like_exists?(comment, user) do
    Queries.exists_query(comment.id, user.id)
    |> Repo.exists?()
  end

  @spec add_like(Comment.t(), User.t()) :: {:ok, Like.t()} | {:error, Changeset.t()}
  def add_like(comment, user) do
    %{}
    |> Map.put(:comment_id, comment.id)
    |> Map.put(:user_id, user.id)
    |> Like.changeset()
    |> Repo.insert()
  end

  @spec remove_like(Comment.t(), User.t()) :: {:ok, Like.t()} | {:error, Changeset.t()}
  def remove_like(comment, user) do
    with like = %Like{} <- Repo.get_by(Like, comment_id: comment.id, user_id: user.id),
         {:ok, _} <- Repo.delete(like) do
      {:ok, like}
    else
      nil ->
        {:error, :like_not_found}

      {:error, error} ->
        {:error, error}
    end
  end
end
