defmodule Blog.Content.ContentsTest do
  use Blog.DataCase

  alias Blog.Content.Contents
  alias Blog.Content.Comment
  alias Blog.Content.Post
  alias Blog.Content.Like

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
      user = insert(:user)

      attrs = %{
        post_id: post.id,
        message: "Lorem ipsum",
        user_id: user.id
      }

      {:ok, %Comment{message: message, post_id: post_id, comment_id: comment_id, reply: reply}} =
        Contents.create_comment(attrs)

      assert message == "Lorem ipsum"
      assert post_id == post.id
      refute comment_id
      refute reply
    end

    test "with invalid attrs not creates a new comment" do
      post = insert(:post)

      attrs = %{
        post_id: post.id,
        message: ""
      }

      {:error, %Ecto.Changeset{valid?: valid}} = Contents.create_comment(attrs)

      refute valid
    end

    test "with valid attrs creates a new reply" do
      post = insert(:post)
      comment = insert(:comment, post: post)
      user = insert(:user)

      attrs = %{
        post_id: post.id,
        comment_id: comment.id,
        message: "Lorem ipsum",
        user_id: user.id
      }

      {:ok, %Comment{message: message, post_id: post_id, comment_id: comment_id, reply: reply}} =
        Contents.create_comment(attrs)

      assert message == "Lorem ipsum"
      assert post_id == post.id
      assert comment_id == comment.id
      assert reply
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

  describe "update_comment/2" do
    test "with valid attrs update comment" do
      comment = insert(:comment, message: "Test 123")

      {:ok, %Comment{message: message}} = Contents.update_comment(comment, "New message")

      assert message == "New message"
    end

    test "with invalid attrs not update comment" do
      comment = insert(:comment, message: "Test 123")

      {:error, %Ecto.Changeset{valid?: valid}} = Contents.update_comment(comment, %{message: ""})

      refute valid
    end
  end

  describe "add_like/2" do
    test "adds a like in a comment" do
      comment = insert(:comment)
      user = insert(:user)

      {:ok, %Like{comment_id: comment_id, user_id: user_id}} = Contents.add_like(comment, user)

      assert comment_id == comment.id
      assert user_id == user.id
    end
  end
end
