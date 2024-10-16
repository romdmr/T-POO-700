defmodule TimeManagerBackend.Repo.Migrations.CreateWorkingTimes do
  use Ecto.Migration

  def change do
    create table(:working_times) do
      add :_start, :utc_datetime
      add :_end, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:working_times, [:user_id])
  end
end
