defmodule BlogWeb.CommentLive.Index do
  use Phoenix.LiveComponent

  alias Blog.Repo

  def render(assigns), do: BlogWeb.CommentView.render("index.html", assigns)

  def update(%{comment: comment}, socket) do
    comment = Repo.preload(comment, replies: :replies)

    socket =
      socket
      |> assign(comment: comment)
      |> assign(show_form: false)

    {:ok, socket}
  end

  def handle_event("add_reply", _, socket) do
    show_form = Map.get(socket.assigns, :show_form)
    {:noreply, assign(socket, show_form: !show_form)}
  end
end
