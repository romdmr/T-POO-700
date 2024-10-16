defmodule TimeManagerBackend.WorkingTimesTest do
  use TimeManagerBackend.DataCase

  alias TimeManagerBackend.WorkingTimes

  describe "working_times" do
    alias TimeManagerBackend.WorkingTimes.WorkingTime

    import TimeManagerBackend.WorkingTimesFixtures

    @invalid_attrs %{_start: nil, _end: nil}

    test "list_working_times/0 returns all working_times" do
      working_time = working_time_fixture()
      assert WorkingTimes.list_working_times() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert WorkingTimes.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{_start: ~U[2024-10-14 15:22:00Z], _end: ~U[2024-10-14 15:22:00Z]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.create_working_time(valid_attrs)
      assert working_time._start == ~U[2024-10-14 15:22:00Z]
      assert working_time._end == ~U[2024-10-14 15:22:00Z]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{_start: ~U[2024-10-15 15:22:00Z], _end: ~U[2024-10-15 15:22:00Z]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.update_working_time(working_time, update_attrs)
      assert working_time._start == ~U[2024-10-15 15:22:00Z]
      assert working_time._end == ~U[2024-10-15 15:22:00Z]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.update_working_time(working_time, @invalid_attrs)
      assert working_time == WorkingTimes.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = WorkingTimes.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimes.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = WorkingTimes.change_working_time(working_time)
    end
  end
end
