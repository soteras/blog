defmodule Blog.Content.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Auth.User
  alias Blog.Content.Comment

  schema "likes" do
    belongs_to :user, User
    belongs_to :comment, Comment

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:user_id, :comment_id])
    |> validate_required([:user_id, :comment_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:comment)
  end
end
