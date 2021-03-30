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
end
