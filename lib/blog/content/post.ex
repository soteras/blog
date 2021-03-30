defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Auth.User

  @create_required_fields [:message, :user_id]

  schema "posts" do
    field :message, :string

    belongs_to :user, User

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @create_required_fields)
    |> validate_required(@create_required_fields)
    |> assoc_constraint(:user)
    |> changeset()
  end

  @doc false
  defp changeset(changeset) do
    changeset
    |> validate_length(:message, max: 280)
  end
end
