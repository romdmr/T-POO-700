defmodule TimeManagerBackend.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerBackend.Clocks` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        _time: ~U[2024-10-14 15:24:00Z],
        status: true
      })
      |> TimeManagerBackend.Clocks.create_clock()

    clock
  end
end
