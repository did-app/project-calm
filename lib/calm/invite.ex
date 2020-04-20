defmodule Calm.Invite do
  use Ecto.Schema

  schema "invites" do
    belongs_to(:thread, Calm.Thread)
    has_many(:messages, Calm.Message)
    field(:nickname, :string)
    field(:color, :string)
    field(:secret_check, :string)

    timestamps(type: :utc_datetime_usec)
  end

  @colors ["gray", "red", "orange", "yellow", "green", "teal", "blue", "indigo", "purple", "pink"]

  def create(thread, params, secret) do
    import Ecto.Changeset

    %Calm.Thread{id: thread_id} = thread
    secret_check = hash_secret(secret)

    %Calm.Invite{}
    |> change(thread_id: thread_id, secret_check: secret_check)
    |> cast(params, [:nickname, :color])
    |> validate_required([:nickname, :color])
    |> unique_constraint([:thread_id, :nickname])
    |> validate_inclusion(:color, @colors)
    |> validate_length(:nickname, min: 2, max: 30)
    |> Calm.Repo.insert()
  end

  def post_message(invite, params) do
    cursor = Calm.Message.count_thread(invite.thread_id)
    Calm.Message.create(invite.id, cursor, params)
  end

  def check_secret(invite, secret) do
    %__MODULE__{secret_check: secret_check} = invite

    case secret_check == hash_secret(secret) do
      true -> {:ok, true}
      false -> {:error, :incorrect_secret}
    end
  end

  def fetch_by_id(id) do
    import Ecto.Query

    query =
      __MODULE__
      |> where([i], i.id == ^id)
      |> preload(thread: [:invites])

    case Calm.Repo.one(query) do
      nil ->
        {:error, :no_invite}

      invite ->
        {:ok, invite}
    end
  end

  def generate_secret() do
    Base.url_encode64(:crypto.strong_rand_bytes(6))
  end

  def hash_secret(secret) do
    Base.url_encode64(:crypto.hash(:sha256, secret))
  end
end
