defmodule Blog.Content.Contents do
  alias Blog.Repo
  alias Blog.Content.Post
  alias Ecto.Changeset

  @type create_params :: %{user_id: integer, message: String.t()}

  @spec create_post(create_params) :: {:ok, Post.t()} | {:error, Changeset.t()}
  def create_post(attrs) do
    attrs
    |> Post.create_changeset()
    |> Repo.insert()
  end
end
