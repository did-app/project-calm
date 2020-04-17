defmodule Calm.Thread do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "threads" do
    field(:subject, :string)
    has_many(:messages, Calm.Message)

    timestamps(type: :utc_datetime_usec)
  end

  def create(params) do
    %__MODULE__{}
    |> Changeset.cast(params, [:subject])
    |> Changeset.validate_required([:subject])
    |> Changeset.validate_length(:subject, min: 5, max: 100)
    |> Calm.Repo.insert()
  end

  def fetch_by_id(id) when is_binary(id) do
    {id, ""} = Integer.parse(id)
    fetch_by_id(id)
  end

  def fetch_by_id(id) when is_integer(id) do
    import Ecto.Query

    query =
      __MODULE__
      |> where([i], i.id == ^id)

    case Calm.Repo.one(query) do
      nil ->
        {:error, :no_thread}

      invite ->
        {:ok, invite}
    end
  end
end