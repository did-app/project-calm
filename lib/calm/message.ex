defmodule Calm.Message do
  use Ecto.Schema

  schema "messages" do
    belongs_to(:invite, Calm.Invite)
    field(:text, :string)
    field(:cursor, :integer)

    timestamps(type: :utc_datetime_usec)
  end

  def load_thread(thread_id) do
    import Ecto.Query

    query =
      __MODULE__
      |> order_by([m], asc: m.inserted_at)
      |> join(:inner, [m], i in Calm.Invite, on: m.invite_id == i.id)
      |> where([m, i], i.thread_id == ^thread_id)
      |> preload([:invite])

    Calm.Repo.all(query)
  end

  def count_thread(thread_id) do
    import Ecto.Query

    query =
      __MODULE__
      |> order_by([m], asc: m.inserted_at)
      |> join(:inner, [m], i in Calm.Invite, on: m.invite_id == i.id)
      |> where([m, i], i.thread_id == ^thread_id)

    Calm.Repo.aggregate(query, :count, :id)
  end

  def create(invite_id, cursor, params) do
    import Ecto.Changeset

    %__MODULE__{}
    |> change(invite_id: invite_id, cursor: cursor)
    |> cast(params, [:text])
    |> validate_required([:text])
    |> validate_length(:text, min: 5)
    |> Calm.Repo.insert()
  end
end
