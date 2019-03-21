defmodule TasktrackerSpa.TaskLists.ListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_item" do
    belongs_to :user, TasktrackerSpa.Users.User
    belongs_to :task, TasktrackerSpa.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:user_id, :task_id])
    |> unique_constraint(:task_id, name: :list_item_user_id_task_id_index)
    |> validate_required([:user_id, :task_id])
  end
end
