defmodule BlogWeb.SigninController do
  use BlogWeb, :controller

  alias Blog.Auth.Users

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"signin" => %{"email" => email, "password" => password}}) do
    case Users.verify_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: Routes.home_path(conn, :index))

      {:error, error} ->
        conn
        |> put_flash(:error, error)
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: Routes.signin_path(conn, :new))
  end
end
