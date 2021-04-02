defmodule Blog.Repo.Migrations.AddReplyColumnOnComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :reply, :boolean, null: false, default: false
    end
  end
end
