defmodule TasktrackerSpaWeb.ListItemView do
  use TasktrackerSpaWeb, :view
  alias TasktrackerSpaWeb.ListItemView

  def render("index.json", %{list_item: list_item}) do
    %{data: render_many(list_item, ListItemView, "list_item.json")}
  end

  def render("show.json", %{list_item: list_item}) do
    %{data: render_one(list_item, ListItemView, "list_item.json")}
  end

  def render("list_item.json", %{list_item: list_item}) do
    %{id: list_item.id}
  end
end
