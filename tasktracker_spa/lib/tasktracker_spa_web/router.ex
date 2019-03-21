defmodule TasktrackerSpaWeb.Router do
  use TasktrackerSpaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasktrackerSpaWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/users", PageController, :index
    get "/register", PageController, :index
    get "/create", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TasktrackerSpaWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/tasks", TaskController, except: [:new, :edit]
    resources "/list_item", ListItemController, except: [:new, :edit]
    post "/auth", AuthController, :authenticate
  end

  # Other scopes may use custom stacks.
  # scope "/api", TasktrackerSpaWeb do
  #   pipe_through :api
  # end
end
