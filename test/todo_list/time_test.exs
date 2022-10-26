defmodule TodoList.TimeTest do
  use TodoList.DataCase

  alias TodoList.Time

  describe "clocks" do
    alias TodoList.Time.Clock

    import TodoList.TimeFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Time.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Time.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %Clock{} = clock} = Time.create_clock(valid_attrs)
      assert clock.email == "some email"
      assert clock.username == "some username"
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %Clock{} = clock} = Time.update_clock(clock, update_attrs)
      assert clock.email == "some updated email"
      assert clock.username == "some updated username"
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_clock(clock, @invalid_attrs)
      assert clock == Time.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Time.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Time.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Time.change_clock(clock)
    end
  end

  describe "clocks" do
    alias TodoList.Time.Clock

    import TodoList.TimeFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Time.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Time.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2022-10-24 11:58:00]}

      assert {:ok, %Clock{} = clock} = Time.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2022-10-24 11:58:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2022-10-25 11:58:00]}

      assert {:ok, %Clock{} = clock} = Time.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2022-10-25 11:58:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_clock(clock, @invalid_attrs)
      assert clock == Time.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Time.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Time.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Time.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias TodoList.Time.WorkingTime

    import TodoList.TimeFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert Time.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert Time.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{end: ~N[2022-10-24 11:59:00], start: ~N[2022-10-24 11:59:00]}

      assert {:ok, %WorkingTime{} = working_time} = Time.create_working_time(valid_attrs)
      assert working_time.end == ~N[2022-10-24 11:59:00]
      assert working_time.start == ~N[2022-10-24 11:59:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{end: ~N[2022-10-25 11:59:00], start: ~N[2022-10-25 11:59:00]}

      assert {:ok, %WorkingTime{} = working_time} = Time.update_working_time(working_time, update_attrs)
      assert working_time.end == ~N[2022-10-25 11:59:00]
      assert working_time.start == ~N[2022-10-25 11:59:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_working_time(working_time, @invalid_attrs)
      assert working_time == Time.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = Time.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> Time.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = Time.change_working_time(working_time)
    end
  end
end
