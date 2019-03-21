defmodule TasktrackerSpaWeb.PageController do
  use TasktrackerSpaWeb, :controller

  def index(conn, _params) do
    tasks =
      TasktrackerSpa.Tasks.list_tasks()
      |> Enum.map(&Map.take(&1, [:id, :title, :desc, :minutes, :completed]))

    users =
      TasktrackerSpa.Users.list_users()
      |> Enum.map(&Map.take(&1, [:id, :email, :admin]))

    render(conn, "index.html", tasks: tasks, users: users)
  end
end
