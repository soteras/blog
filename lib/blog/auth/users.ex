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

  @spec verify_user(String.t(), String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def verify_user(email, password) do
    with user = %User{} <- Repo.get_by(User, email: email),
         {:ok, _} <- Bcrypt.check_pass(user, password, hash_key: :password) do
      {:ok, user}
    else
      nil -> {:error, "email or password are not correct"}
      {:error, _} -> {:error, "email or password are not correct"}
    end
  end
end
