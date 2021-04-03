defmodule BlogWeb.CommentLive.Index do
  use Phoenix.LiveComponent

  alias Blog.Repo
  alias Blog.Content.Contents
  alias BlogWeb.PostLive.Show
  alias BlogWeb.Router.Helpers, as: Routes

  def render(assigns), do: BlogWeb.CommentView.render("index.html", assigns)

  def update(%{comment: comment, user: user}, socket) do
    comment = Repo.preload(comment, [:user, replies: :replies])

    like_exists? = Contents.like_exists?(comment, user)

    socket =
      socket
      |> assign(comment: comment)
      |> assign(show_create_form: false)
      |> assign(show_update_form: false)
      |> assign(belongs_to_user: comment.user_id == user.id)
      |> assign(user: user)
      |> assign(liked: like_exists?)

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

  def handle_event("add_like", _, socket) do
    comment = socket.assigns.comment
    user = socket.assigns.user

    unless Contents.like_exists?(comment, user) do
      Contents.add_like(comment, user)
    end

    {:noreply, redirect(socket, to: Routes.live_path(socket, Show, comment.post_id))}
  end

  def handle_event("remove_like", _, socket) do
    comment = socket.assigns.comment
    user = socket.assigns.user

    if Contents.like_exists?(comment, user) do
      Contents.remove_like(comment, user)
    end

    {:noreply, redirect(socket, to: Routes.live_path(socket, Show, comment.post_id))}
  end
end
