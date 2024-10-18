defmodule TimeManagerBackend.WorkingTimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field :_start, :utc_datetime
    field :_end, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:_start, :_end])
    |> validate_required([:_start, :_end])
  end
end
