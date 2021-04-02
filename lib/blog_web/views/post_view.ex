defmodule BlogWeb.PostView do
  use BlogWeb, :view

  alias Blog.Repo

  def build_messages([]), do: []

  def build_messages(comments) do
    content_tag(:ul) do
      [
        for comment <- comments do
          comment = Repo.preload(comment, :replies)

          content_tag(:li) do
            [
              comment.message,
              build_messages(comment.replies)
            ]
          end
        end
      ]
    end
  end
end
