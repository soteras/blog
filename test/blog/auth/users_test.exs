defmodule Blog.Auth.UsersTest do
  use Blog.DataCase

  alias Blog.Auth.Users
  alias Blog.Auth.User

  describe "create/1" do
    @valid_attrs %{
      name: "Maria da Silva",
      email: "maria@gmail.com",
      password: "abc12345",
      password_confirmation: "abc12345"
    }

    @invalid_attrs %{
      name: "",
      email: "maria@gmail.com",
      password: "abc12345",
      password_confirmation: "abc12345"
    }

    test "returns user when attrs is valid" do
      {:ok, %User{name: name, email: email}} = Users.create(@valid_attrs)

      assert name == "Maria da Silva"
      assert email == "maria@gmail.com"
    end

    test "returns an error when attrs is invalid" do
      {:error, %Ecto.Changeset{valid?: valid}} = Users.create(@invalid_attrs)

      refute valid
    end
  end

  describe "verify_user/2" do
    test "returns user when email and password is valid" do
      insert(:user, email: "maria@gmail.com", password: "abc12345")

      {:ok, %User{email: email}} = Users.verify_user("maria@gmail.com", "abc12345")

      assert email == "maria@gmail.com"
    end

    test "returns an error when email not exist" do
      {:error, error} = Users.verify_user("maria@gmail.com", "abc12345")

      assert error == "email or password are not correct"
    end

    test "returns an error when password is not valid" do
      insert(:user, email: "maria@gmail.com", password: "abc12345")

      {:error, error} = Users.verify_user("maria@gmail.com", "wrong")

      assert error == "email or password are not correct"
    end
  end
end
