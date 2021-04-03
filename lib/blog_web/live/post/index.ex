defmodule BlogWeb.PostLive.Index do
  use Phoenix.LiveView

  alias Blog.Content.Contents
  alias BlogWeb.PostView

  def render(assigns), do: PostView.render("index.html", assigns)

  def mount(_params, %{"current_user" => user}, socket) do
    socket =
      socket
      |> fetch_posts()
      |> assign(user: user.id)

    {:ok, socket}
  end

  defp fetch_posts(socket) do
    posts = Contents.get_all_posts()
    assign(socket, posts: posts)
  end
end
