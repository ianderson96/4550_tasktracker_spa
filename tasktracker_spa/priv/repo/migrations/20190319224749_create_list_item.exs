defmodule TasktrackerSpa.Repo.Migrations.CreateListItem do
  use Ecto.Migration

  def change do
    create table(:list_item) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:list_item, [:user_id])
    create index(:list_item, [:task_id])
    create index(:list_item, [:user_id, :task_id], unique: true)
  end
end
