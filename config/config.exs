use Mix.Config


config :calm,
  ecto_repos: [Calm.Repo]

config :calm, Calm.Repo,
  # it can be overridden using the DATABASE_URL environment variable
  url: "ecto://z5XKESER:LS8jTnO4IZeebZuLJ5@localhost:6543/calm?ssl=false&pool_size=10"

if Mix.env() == :test do
config :calm, Calm.Repo,
  pool: Ecto.Adapters.SQL.Sandbox
end


if Mix.env() == :dev do
  config :exsync,
    extra_extensions: [".js", ".css"]
end

