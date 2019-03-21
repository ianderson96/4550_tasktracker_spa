defmodule TasktrackerSpa.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password_hash, :string
    has_many :list_item, TasktrackerSpa.TaskLists.ListItem

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash, :admin])
    |> unique_constraint(:email)
    |> validate_required([:email, :password_hash, :admin])
  end
end
