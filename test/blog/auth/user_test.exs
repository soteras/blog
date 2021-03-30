defmodule Blog.Auth.UserTest do
  use Blog.DataCase

  alias Blog.Auth.User

  describe "create_changeset/1" do
    @valid_attrs %{
      name: "Maria da Silva",
      email: "maria@gmail.com",
      password: "abc12345",
      password_confirmation: "abc12345"
    }

    test "with valid attrs creates a new user" do
      %Ecto.Changeset{
        valid?: valid,
        changes: %{name: name, email: email}
      } = User.create_changeset(@valid_attrs)

      assert valid
      assert name == "Maria da Silva"
      assert email == "maria@gmail.com"
    end
  end

  describe "name validations" do
    test "name required" do
      attrs = %{@valid_attrs | name: ""}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :name) == "can't be blank"
    end

    test "name length" do
      attrs = %{@valid_attrs | name: duplicate_string("a", 41)}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :name) == "should be at most %{count} character(s)"
    end
  end

  describe "email validations" do
    test "email required" do
      attrs = %{@valid_attrs | email: ""}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :email) == "can't be blank"
    end

    test "email length" do
      attrs = %{@valid_attrs | email: duplicate_string("@", 301)}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :email) == "should be at most %{count} character(s)"
    end

    test "email format" do
      attrs = %{@valid_attrs | email: "maria.com"}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :email) == "has invalid format"
    end

    test "email unique" do
      insert(:user, email: "maria@gmail.com")
      attrs = %{@valid_attrs | email: "maria@gmail.com"}

      {:error, changeset} =
        attrs
        |> User.create_changeset()
        |> Blog.Repo.insert()

      assert get_error_message(changeset, :email) == "has already been taken"
    end
  end

  describe "password validations" do
    test "password required" do
      attrs = %{@valid_attrs | password: ""}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :password) == "can't be blank"
    end

    test "name is less than 8" do
      attrs = %{@valid_attrs | password: duplicate_string("a", 7)}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :password) == "should be at least %{count} character(s)"
    end

    test "name more than than 100" do
      attrs = %{@valid_attrs | password: duplicate_string("a", 101)}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :password) == "should be at most %{count} character(s)"
    end

    test "confirmation not match" do
      attrs = %{@valid_attrs | password: "abc12345", password_confirmation: "abc123456"}
      changeset = User.create_changeset(attrs)

      assert get_error_message(changeset, :password_confirmation) == "does not match password"
    end
  end
end
