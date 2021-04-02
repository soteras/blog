defmodule Blog.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias BlogWeb.Router.Helpers, as: Routes

  def redirect_if_user_is_authenticated(conn, _opts) do
    if get_session(conn, :current_user) do
      conn
      |> redirect(to: "/")
      |> halt()
    else
      conn
    end
  end

  def require_authenticated_user(conn, _opts) do
    if get_session(conn, :current_user) do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: Routes.signin_path(conn, :new))
      |> halt()
    end
  end
end
