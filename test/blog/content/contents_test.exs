defmodule Blog.Content.ContentsTest do
  use Blog.DataCase

  alias Blog.Content.Contents
  alias Blog.Content.Post

  describe "create_post/1" do
    test "with valid attrs creates a new post" do
      user = insert(:user)
      attrs = %{message: "Lorem ipsum", user_id: user.id}

      {:ok, %Post{message: message, user_id: user_id}} = Contents.create_post(attrs)

      assert message == "Lorem ipsum"
      assert user_id == user.id
    end

    test "with invalid attrs not creates a new post" do
      attrs = %{message: ""}

      {:error, %Ecto.Changeset{valid?: valid}} = Contents.create_post(attrs)

      refute valid
    end
  end
end
