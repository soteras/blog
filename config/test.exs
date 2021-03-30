use Mix.Config

config :blog, Blog.Repo,
  username: "blog_user",
  password: "blog_pass",
  database: "blog_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

config :blog, BlogWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
