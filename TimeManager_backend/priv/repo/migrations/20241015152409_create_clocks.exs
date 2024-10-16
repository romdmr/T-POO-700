defmodule TimeManagerBackend.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :_time, :utc_datetime
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:clocks, [:user_id])
  end
end
