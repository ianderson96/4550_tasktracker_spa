defmodule TasktrackerSpa.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :desc, :string, null: false
      add :title, :string, null: false
      add :minutes, :integer
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

    create index(:tasks, [:title], unique: true)
  end
end
