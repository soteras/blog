defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :message, :string, null: false, size: 280
      add :post_id, references(:posts, on_delete: :delete_all), null: false
      add :comment_id, references(:comments, on_delete: :delete_all), null: true

      timestamps()
    end

    create index(:comments, [:post_id])
    create index(:comments, [:comment_id])
  end
end
