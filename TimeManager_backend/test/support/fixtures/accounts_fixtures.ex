defmodule TimeManagerBackend.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerBackend.Accounts` context.
  """

  @doc """
  Generate a unique role name.
  """
  def unique_role_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: unique_role_name()
      })
      |> TimeManagerBackend.Accounts.create_role()

    role
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        password: "some password"
      })
      |> TimeManagerBackend.Accounts.create_user()

    user
  end
end
