defmodule BlogWeb.CommentControllerTest do
  use BlogWeb.ConnCase

  describe "create" do
    test "creates a new comment when attrs are valid", %{conn: conn} do
      user = insert(:user)
      post = insert(:post, user: user)

      attrs = %{
        message: "Test 123",
        post_id: post.id
      }

      conn =
        user
        |> signin_user(conn)
        |> post(Routes.comment_path(conn, :create), comment: attrs)

      assert redirected_to(conn) == Routes.post_path(conn, :show, post.id)
      assert get_flash(conn, :info) == "Comment created successfully."
    end

    test "not creates a new comment when attrs are invalid ", %{conn: conn} do
      user = insert(:user)
      post = insert(:post, user: user)

      attrs = %{
        message: "",
        post_id: post.id
      }

      conn =
        user
        |> signin_user(conn)
        |> post(Routes.comment_path(conn, :create), comment: attrs)

      assert redirected_to(conn) == Routes.post_path(conn, :show, post.id)
      assert get_flash(conn, :error) == "Error to create comment."
    end
  end
end
