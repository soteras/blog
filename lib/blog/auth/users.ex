defmodule Blog.Auth.Users do
  alias Blog.Repo
  alias Blog.Auth.User
  alias Ecto.Changeset

  @type create_params :: %{
          name: String.t(),
          email: String.t(),
          password: String.t(),
          password_confirmation: String.t()
        }

  @spec create(create_params) :: {:ok, User.t()} | {:error, Changeset.t()}
  def create(attrs) do
    attrs
    |> User.create_changeset()
    |> Repo.insert()
  end
end
