defmodule TasktrackerSpaWeb.ListItemController do
  use TasktrackerSpaWeb, :controller

  alias TasktrackerSpa.TaskLists
  alias TasktrackerSpa.TaskLists.ListItem

  action_fallback TasktrackerSpaWeb.FallbackController

  def index(conn, _params) do
    list_item = TaskLists.list_list_item()
    render(conn, "index.json", list_item: list_item)
  end

  def create(conn, %{"list_item" => list_item_params}) do
    with {:ok, %ListItem{} = list_item} <- TaskLists.create_list_item(list_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.list_item_path(conn, :show, list_item))
      |> render("show.json", list_item: list_item)
    end
  end

  def show(conn, %{"id" => id}) do
    list_item = TaskLists.get_list_item!(id)
    render(conn, "show.json", list_item: list_item)
  end

  def update(conn, %{"id" => id, "list_item" => list_item_params}) do
    list_item = TaskLists.get_list_item!(id)

    with {:ok, %ListItem{} = list_item} <- TaskLists.update_list_item(list_item, list_item_params) do
      render(conn, "show.json", list_item: list_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    list_item = TaskLists.get_list_item!(id)

    with {:ok, %ListItem{}} <- TaskLists.delete_list_item(list_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
