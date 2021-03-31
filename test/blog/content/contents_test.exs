defmodule Blog.Content.ContentsTest do
  use Blog.DataCase

  alias Blog.Content.Contents
  alias Blog.Content.Comment
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

  describe "create_comment/2" do
    test "with valid attrs creates a new comment" do
      post = insert(:post)

      {:ok, %Comment{message: message, post_id: post_id, comment_id: comment_id}} =
        Contents.create_comment(post, "Lorem ipsum")

      assert message == "Lorem ipsum"
      assert post_id == post.id
      refute comment_id
    end

    test "with invalid attrs not creates a new comment" do
      post = insert(:post)

      {:error, %Ecto.Changeset{valid?: valid}} = Contents.create_comment(post, "")

      refute valid
    end
  end

  describe "create_reply/3" do
    test "with valid attrs creates a new reply" do
      post = insert(:post)
      comment = insert(:comment, post: post)

      {:ok, %Comment{message: message, post_id: post_id, comment_id: comment_id}} =
        Contents.create_reply(post, comment, "Lorem ipsum")

      assert message == "Lorem ipsum"
      assert post_id == post.id
      assert comment_id == comment.id
    end

    test "with invalid attrs not creates a new reply" do
      post = insert(:post)
      comment = insert(:comment, post: post)

      {:error, %Ecto.Changeset{valid?: valid}} = Contents.create_reply(post, comment, "")

      refute valid
    end
  end

  describe "get_all_posts/0" do
    test "returns all posts" do
      user = insert(:user)
      insert(:post, user: user)
      insert(:post, user: user)

      posts = Contents.get_all_posts()

      assert length(posts) == 2
    end

    test "returns an empty list when posts not exist" do
      posts = Contents.get_all_posts()

      assert posts == []
    end
  end

  describe "get_post/1" do
    test "returns post when post exist" do
      post = insert(:post)

      result = Contents.get_post(post.id)

      assert post.id == result.id
    end

    test "returns nil when post not exist" do
      refute Contents.get_post(1)
    end
  end
end
