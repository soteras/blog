defmodule BlogWeb.PostLive.Show do
  use Phoenix.LiveView

  alias Blog.Content.Contents
  alias BlogWeb.PostView

  def render(assigns), do: PostView.render("show.html", assigns)

  def mount(%{"id" => id}, %{"current_user" => user}, socket) do
    socket =
      socket
      |> assign(user_id: user.id)
      |> fetch_post(id)

    {:ok, socket}
  end

  defp fetch_post(socket, id) do
    post = Contents.get_post(id)
    assign(socket, post: post)
  end
end
