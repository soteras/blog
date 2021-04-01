defmodule BlogWeb.SignupControllerTest do
  use BlogWeb.ConnCase

  describe "create user" do
    @valid_attrs %{
      name: "Maria",
      email: "maria@gmail.com",
      password: "abc12345",
      password_confirmation: "abc12345"
    }
    @invalid_attrs %{
      name: "",
      email: "mariagmail.com",
      password: "abc12345",
      password_confirmation: "abc12345"
    }

    test "creates a new user when attrs are valid", %{conn: conn} do
      conn = post(conn, Routes.signup_path(conn, :create), user: @valid_attrs)
      assert redirected_to(conn) == Routes.home_path(conn, :index)
    end

    test "not creates a new user when atrrs are invalid ", %{conn: conn} do
      conn = post(conn, Routes.signup_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Signup"
    end
  end
end
