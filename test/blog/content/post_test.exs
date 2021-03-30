defmodule Blog.Content.PostTest do
  use Blog.DataCase

  alias Blog.Content.Post

  describe "create_changeset/1" do
    test "with valid attrs creates a new post" do
      user = insert(:user)
      attrs = %{message: "Lorem ipsum", user_id: user.id}

      %Ecto.Changeset{
        valid?: valid,
        changes: %{message: message, user_id: user_id}
      } = Post.create_changeset(attrs)

      assert valid
      assert message == "Lorem ipsum"
      assert user_id == user.id
    end
  end

  describe "message validations" do
    test "message required" do
      attrs = %{message: ""}
      changeset = Post.create_changeset(attrs)

      assert get_error_message(changeset, :message) == "can't be blank"
    end

    test "message length" do
      attrs = %{message: duplicate_string("a", 281)}
      changeset = Post.create_changeset(attrs)

      assert get_error_message(changeset, :message) == "should be at most %{count} character(s)"
    end
  end

  describe "user validations" do
    test "user required" do
      attrs = %{user_id: nil}
      changeset = Post.create_changeset(attrs)

      assert get_error_message(changeset, :user_id) == "can't be blank"
    end
  end
end
