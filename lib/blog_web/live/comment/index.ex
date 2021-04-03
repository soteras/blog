defmodule BlogWeb.CommentLive.Index do
  use Phoenix.LiveComponent

  alias Blog.Repo

  def render(assigns), do: BlogWeb.CommentView.render("index.html", assigns)

  def update(%{comment: comment, user_id: user_id}, socket) do
    comment = Repo.preload(comment, [:user, replies: :replies])

    socket =
      socket
      |> assign(comment: comment)
      |> assign(show_create_form: false)
      |> assign(show_update_form: false)
      |> assign(belongs_to_user: comment.user_id == user_id)
      |> assign(user_id: user_id)

    {:ok, socket}
  end

  def handle_event("add_reply", _, socket) do
    show_create_form = Map.get(socket.assigns, :show_create_form)
    {:noreply, assign(socket, show_create_form: !show_create_form)}
  end

  def handle_event("update_comment", _, socket) do
    show_update_form = Map.get(socket.assigns, :show_update_form)
    {:noreply, assign(socket, show_update_form: !show_update_form)}
  end
end
