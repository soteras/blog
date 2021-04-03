defmodule BlogWeb.CommentLive.Update do
  use Phoenix.LiveComponent

  alias BlogWeb.PostLive.Show
  alias Blog.Content.Contents
  alias Blog.Content.Comment
  alias BlogWeb.Router.Helpers, as: Routes

  def render(assigns), do: BlogWeb.CommentView.render("form.html", assigns)

  def update(%{comment: comment, user_id: user_id}, socket) do
    changeset = Comment.create_changeset(%{message: comment.message})

    socket =
      socket
      |> assign(comment: comment)
      |> assign(changeset: changeset)
      |> assign(user_id: user_id)

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
    comment = socket.assigns.comment
    user_id = socket.assigns.user_id

    with true <- comment.user_id == user_id,
         {:ok, _} <- Contents.update_comment(comment, message) do
      socket =
        socket
        |> put_flash(:info, "comment created")
        |> redirect(to: Routes.live_path(socket, Show, comment.post_id))

      {:noreply, socket}
    else
      false ->
        {:noreply, put_flash(socket, :error, "comment not belongs to user")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
