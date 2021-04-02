defmodule BlogWeb.PostLive.New do
  use Phoenix.LiveComponent

  alias Blog.Content.Contents
  alias Blog.Content.Post
  alias BlogWeb.PostView
  alias BlogWeb.PostLive.Index
  alias BlogWeb.Router.Helpers, as: Routes

  def render(assigns), do: PostView.render("form.html", assigns)

  def update(assigns, socket) do
    changeset = Post.create_changeset(%{})

    socket =
      socket
      |> assign(user_id: assigns.user_id)
      |> assign(changeset: changeset)

    {:ok, socket}
  end

  def handle_event("validate", %{"post" => post_params}, socket) do
    changeset =
      post_params
      |> Post.create_changeset()
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    post_params =
      post_params
      |> Map.put("user_id", socket.assigns.user_id)

    case Contents.create_post(post_params) do
      {:ok, _} ->
        socket =
          socket
          |> put_flash(:info, "post created")
          |> redirect(to: Routes.live_path(socket, Index))

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
