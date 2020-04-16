defmodule Calm.Repo do
  use Ecto.Repo,
  otp_app: :calm,
  adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    # SEE https://hexdocs.pm/ecto/Ecto.Repo.html#module-urls for details
    config =
      case System.get_env("DATABASE_URL") do
        not_set when not_set in [nil, ""] ->
          config
        url ->
          Keyword.put(config, :url, url)
      end
    {:ok, config}
  end
end

