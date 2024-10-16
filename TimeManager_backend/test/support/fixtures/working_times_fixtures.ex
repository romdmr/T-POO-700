defmodule TimeManagerBackend.WorkingTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerBackend.WorkingTimes` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        _end: ~U[2024-10-14 15:22:00Z],
        _start: ~U[2024-10-14 15:22:00Z]
      })
      |> TimeManagerBackend.WorkingTimes.create_working_time()

    working_time
  end
end
