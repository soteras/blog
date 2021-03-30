defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false, size: 40
      add :email, :string, null: false, size: 300
      add :password, :string, null: false, size: 400

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
