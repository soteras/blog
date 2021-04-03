defmodule BlogWeb.CommentLive.New do
  use Phoenix.LiveComponent

  alias BlogWeb.PostLive.Show
  alias Blog.Content.Contents
  alias Blog.Content.Comment
  alias BlogWeb.Router.Helpers, as: Routes

  def render(assigns), do: BlogWeb.CommentView.render("form.html", assigns)

  def update(%{user: user, post: post} = params, socket) do
    changeset = Comment.create_changeset(%{})
    comment = Map.get(params, :comment, nil)

    socket =
      socket
      |> assign(comment: comment)
      |> assign(changeset: changeset)
      |> assign(user: user)
      |> assign(post: post)

    {:ok, socket}
  end

  def handle_event("validate", %{"comment" => %{"message" => message}}, socket) do
    attrs = %{
      message: message
    }

    changeset =
      attrs
      |> Comment.create_changeset()
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"comment" => %{"message" => message}}, socket) do
    comment = Map.get(socket.assigns, :comment) || %{}
    user = socket.assigns.user
    post = socket.assigns.post

    attrs = %{
      message: message,
      comment_id: Map.get(comment, :id, nil),
      post_id: post.id,
      user_id: user.id
    }

    case Contents.create_comment(attrs) do
      {:ok, _} ->
        socket =
          socket
          |> put_flash(:info, "comment created")
          |> redirect(to: Routes.live_path(socket, Show, comment.post))

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
