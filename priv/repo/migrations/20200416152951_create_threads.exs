defmodule Calm.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add(:subject, :string, null: false)

      timestamps(type: :utc_datetime_usec)
    end

    create table(:invites) do
      add(:thread_id, references(:threads), null: false)

      add(:nickname, :string, null: false)
      add(:color, :string, null: false)
      add(:secret_check, :string, null: false)

      timestamps(type: :utc_datetime_usec)
    end

    create table(:messages) do
      add(:text, :text, null: false)
      add(:invite_id, references(:invites), null: false)
      add(:cursor, :integer, null: false)

      timestamps(type: :utc_datetime_usec)
    end

    create(unique_index(:invites, [:thread_id, :nickname]))
  end
end
