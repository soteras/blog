defmodule Blog.Content.CommentTest do
  use Blog.DataCase

  alias Blog.Content.Comment

  describe "create_changeset/1" do
    test "with valid attrs creates a new comment" do
      post = insert(:post)
      attrs = %{message: "Lorem ipsum", post_id: post.id}

      %Ecto.Changeset{
        valid?: valid,
        changes: %{message: message, post_id: post_id}
      } = Comment.create_changeset(attrs)

      assert valid
      assert message == "Lorem ipsum"
      assert post_id == post_id
    end
  end

  describe "message validations" do
    test "message required" do
      attrs = %{message: ""}
      changeset = Comment.create_changeset(attrs)

      assert get_error_message(changeset, :message) == "can't be blank"
    end

    test "message length" do
      attrs = %{message: duplicate_string("a", 281)}
      changeset = Comment.create_changeset(attrs)

      assert get_error_message(changeset, :message) == "should be at most %{count} character(s)"
    end
  end

  describe "post validations" do
    test "post_id required" do
      attrs = %{post_id: nil}
      changeset = Comment.create_changeset(attrs)

      assert get_error_message(changeset, :post_id) == "can't be blank"
    end
  end
end
