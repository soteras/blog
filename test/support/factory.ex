defmodule Blog.Factory do
  use ExMachina.Ecto, repo: Blog.Repo

  alias Blog.Auth.User

  def user_factory do
    %User{
      name: "José Antonio",
      email: "jose@gmail.com",
      password: "abc12345"
    }
  end
end
