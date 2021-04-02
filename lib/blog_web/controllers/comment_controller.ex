defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.Content.Contents

  def create(conn, %{"comment" => %{"post_id" => post_id, "message" => message} = params}) do
    comment_id = Map.get(params, "comment_id", nil)

    attrs = %{
      post_id: post_id,
      comment_id: comment_id,
      message: message
    }

    case Contents.create_comment(attrs) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      _ ->
        conn
        |> put_flash(:error, "Error to create comment.")
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end
  end
end
