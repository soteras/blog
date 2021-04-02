defmodule BlogWeb.SignupController do
  use BlogWeb, :controller

  alias Blog.Auth.Users
  alias Blog.Auth.User

  def new(conn, _params) do
    changeset = User.create_changeset(%{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
