defmodule BlogWeb.HomeControllerTest do
  use BlogWeb.ConnCase

  describe "index" do
    test "creates a new user when attrs are valid", %{conn: conn} do
      conn =
        insert(:user)
        |> signin_user(conn)
        |> get(Routes.home_path(conn, :index))

      assert html_response(conn, 200) =~ "Home Page"
    end
  end
end
