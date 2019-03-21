defmodule TasktrackerSpa.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :minutes, :integer
    field :title, :string
    has_one :list_item, TasktrackerSpa.TaskLists.ListItem

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:desc, :title, :minutes, :completed])
    |> unique_constraint(:title)
    |> validate_required([:desc, :title, :minutes, :completed])
  end
end
