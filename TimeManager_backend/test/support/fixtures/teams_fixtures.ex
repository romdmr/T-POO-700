defmodule TimeManagerBackend.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerBackend.Teams` context.
  """

  @doc """
  Generate a unique team name.
  """
  def unique_team_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: unique_team_name()
      })
      |> TimeManagerBackend.Teams.create_team()

    team
  end
end
