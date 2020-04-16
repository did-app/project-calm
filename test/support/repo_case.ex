defmodule Calm.RepoCase do
  use ExUnit.CaseTemplate
  # SEE https://hexdocs.pm/ecto/testing-with-ecto.html for more information

  using do
    quote do
      # alias Calm.Repo

      # import Ecto
      # import Ecto.Query
      # import Calm.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Calm.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Calm.Repo, {:shared, self()})
    end

    :ok
  end
end

