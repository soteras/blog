defmodule Blog.Factory do
  use ExMachina.Ecto, repo: Blog.Repo

  alias Blog.Auth.User
  alias Blog.Content.Post

  def user_factory do
    %User{
      name: "José Antonio",
      email: "jose@gmail.com",
      password: "abc12345"
    }
  end

  def post_factory do
    %Post{
      message: "Lorem ipsum",
      user: build(:user)
    }
  end
end
