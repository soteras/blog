defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  describe "index" do
    test "show all posts ", %{conn: conn} do
      user = insert(:user)
      insert(:post, message: "Message 1", user: user)
      insert(:post, message: "Message 2", user: user)

      conn =
        user
        |> signin_user(conn)
        |> get(Routes.post_path(conn, :index))

      assert html_response(conn, 200) =~ "Message 1"
      assert html_response(conn, 200) =~ "Message 2"
    end
  end

  describe "show" do
    test "show post ", %{conn: conn} do
      user = insert(:user)
      post = insert(:post, message: "Message 1", user: user)
      comment = insert(:comment, message: "Comment 1", post: post)
      insert(:comment, message: "Reply 1", post: post, parent: comment)

      conn =
        user
        |> signin_user(conn)
        |> get(Routes.post_path(conn, :show, post.id))

      assert html_response(conn, 200) =~ "Message 1"
      assert html_response(conn, 200) =~ "Comment 1"
      assert html_response(conn, 200) =~ "Reply 1"
    end
  end
end
