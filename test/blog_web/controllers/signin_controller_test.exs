defmodule BlogWeb.SigninControllerTest do
  use BlogWeb.ConnCase

  describe "signin create" do
    test "redirects to home when login was success ", %{conn: conn} do
      insert(:user, email: "jose@gmail.com")
      attrs = %{email: "jose@gmail.com", password: "abc12345"}

      conn = post(conn, Routes.signin_path(conn, :create), signin: attrs)

      assert redirected_to(conn) == "/"
    end

    test "returns an erro when login was unsuccess ", %{conn: conn} do
      insert(:user)
      attrs = %{email: "jose@gmail.com", password: "abc1111"}

      conn = post(conn, Routes.signin_path(conn, :create), signin: attrs)
      assert html_response(conn, 200) =~ "Signin"
      assert get_flash(conn, :error) == "email or password are not correct"
    end
  end

  describe "signin delete" do
    test "removes sessions and redirects to login page ", %{conn: conn} do
      conn =
        insert(:user)
        |> signin_user(conn)
        |> delete(Routes.signin_path(conn, :delete))

      assert redirected_to(conn) == Routes.signin_path(conn, :new)
      assert get_flash(conn, :info) == "Signed out successfully."
    end
  end
end
