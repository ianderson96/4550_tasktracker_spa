defmodule TasktrackerSpaWeb.ListItemControllerTest do
  use TasktrackerSpaWeb.ConnCase

  alias TasktrackerSpa.TaskLists
  alias TasktrackerSpa.TaskLists.ListItem

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:list_item) do
    {:ok, list_item} = TaskLists.create_list_item(@create_attrs)
    list_item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all list_item", %{conn: conn} do
      conn = get(conn, Routes.list_item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create list_item" do
    test "renders list_item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.list_item_path(conn, :create), list_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.list_item_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.list_item_path(conn, :create), list_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update list_item" do
    setup [:create_list_item]

    test "renders list_item when data is valid", %{conn: conn, list_item: %ListItem{id: id} = list_item} do
      conn = put(conn, Routes.list_item_path(conn, :update, list_item), list_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.list_item_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, list_item: list_item} do
      conn = put(conn, Routes.list_item_path(conn, :update, list_item), list_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete list_item" do
    setup [:create_list_item]

    test "deletes chosen list_item", %{conn: conn, list_item: list_item} do
      conn = delete(conn, Routes.list_item_path(conn, :delete, list_item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.list_item_path(conn, :show, list_item))
      end
    end
  end

  defp create_list_item(_) do
    list_item = fixture(:list_item)
    {:ok, list_item: list_item}
  end
end
