defmodule TimeManagerBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:firstname, :string, size: 50, null: false)
      add(:lastname, :string, size: 50, null: false)
      add(:email, :string, size: 255, null: false)
      add(:password, :string, size: 255, null: false)
      add(:team_id, references(:teams, on_delete: :nothing))
      add(:role_id, references(:roles, on_delete: :nothing))

      timestamps(type: :utc_datetime)
    end

    create(index(:users, [:team_id]))
    create(index(:users, [:role_id]))
  end
end
