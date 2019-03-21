defmodule TasktrackerSpaWeb.TaskView do
  use TasktrackerSpaWeb, :view
  alias TasktrackerSpaWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      desc: task.desc,
      title: task.title,
      minutes: task.minutes,
      completed: task.completed}
  end
end
