defmodule TimeManagerBackend.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add(:name, :string, size: 50, null: false)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:roles, [:name]))
  end
end
