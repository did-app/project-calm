defmodule Calm.Message do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "messages" do
    field(:text, :string)

    timestamps(type: :utc_datetime_usec)
  end
end
