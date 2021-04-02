defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Content.Contents

  def index(conn, _params) do
    posts = Contents.get_all_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Contents.get_post(id)
    render(conn, "show.html", post: post)
  end
end
