defmodule BlogWeb.Router do
  use BlogWeb, :router

  import Blog.Auth

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

  scope "/", BlogWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    resources "/signin", SigninController, only: [:new, :create]
    resources "/users", SignupController, only: [:new, :create]
  end

  scope "/", BlogWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", HomeController, :index
    delete "/signout", SigninController, :delete
    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, only: [:create]
  end

  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through :browser
  #     live_dashboard "/dashboard", metrics: BlogWeb.Telemetry
  #   end
  # end
end
