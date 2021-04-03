defmodule Blog.Factory do
  use ExMachina.Ecto, repo: Blog.Repo

  alias Blog.Auth.User
  alias Blog.Content.Comment
  alias Blog.Content.Post
  alias Blog.Content.Like

  def user_factory do
    email = for _ <- 1..10, into: "", do: <<Enum.random('0123456789abcdef')>>

    %User{
      name: "José Antonio",
      email: email <> "gmail.com",
      password: Bcrypt.hash_pwd_salt("abc12345")
    }
  end

  def post_factory do
    %Post{
      message: "Lorem ipsum",
      user: build(:user)
    }
  end

  def comment_factory do
    %Comment{
      message: "Lorem ipsum",
      post: build(:post),
      user: build(:user)
    }
  end

  def like_factory do
    %Like{
      user: build(:user),
      comment: build(:comment)
    }
  end
end
