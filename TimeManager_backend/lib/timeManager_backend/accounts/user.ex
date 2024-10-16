defmodule TimeManagerBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :team_id, :id
    field :role_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password])
    |> validate_required([:firstname, :lastname, :email, :password])
  end
end
