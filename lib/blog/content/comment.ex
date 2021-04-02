defmodule Blog.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Blog.Content.Post

  @create_required_fields [:message, :post_id]

  schema "comments" do
    field :message, :string
    field :reply, :boolean, default: false

    belongs_to :post, Post
    belongs_to :parent, Comment, foreign_key: :comment_id
    has_many :replies, Comment

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @create_required_fields ++ [:comment_id])
    |> validate_required(@create_required_fields)
    |> assoc_constraint(:post)
    |> changeset
  end

  @doc false
  defp changeset(changeset) do
    changeset
    |> validate_length(:message, max: 280)
    |> put_reply_flag()
  end

  defp put_reply_flag(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{comment_id: _}} ->
        put_change(changeset, :reply, true)

      _ ->
        changeset
    end
  end
end
