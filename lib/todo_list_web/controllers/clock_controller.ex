defmodule TodoListWeb.ClockController do
  use TodoListWeb, :controller

  alias TodoList.Time
  alias TodoList.Time.Clock

  action_fallback TodoListWeb.FallbackController

  defp key_to_atom(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      {key, value}, acc when is_binary(key) -> Map.put(acc, String.to_existing_atom(key), value)
    end)
  end

  def show(conn, %{"userID" => user_id}) do
    clock_cond = Time.get_clock_by_user_id(user_id)

    case clock_cond do
      {:ok, %Clock{} = clock} ->
        conn
        |> put_status(:ok)
        |> render("show.json", clock: clock)

      _ ->
        conn
        |> create(%{userID: user_id, clock: %{status: false, time: nil}})
    end
  end

  def clock(conn, %{"userID" => user_id, "clock" => %{"status" => "0"}}) do
    clock_cond = Time.get_clock_by_user_id(user_id)

    IO.puts("False")

    case clock_cond do
      {:ok, %Clock{} = clock} ->
        with {:ok, %Clock{} = clock} <- Time.update_clock(clock, %{status: false, time: nil}) do
          conn
          |> put_status(:ok)
          |> render("show.json", clock: clock)
        end

      _ ->
        conn
        |> create(%{userID: user_id, clock: %{status: false, time: nil}})
    end
  end

  def clock(conn, %{"userID" => user_id, "clock" => %{"status" => "1", "time" => time}}) do
    clock_cond = Time.get_clock_by_user_id(user_id)

    IO.puts("True")

    case clock_cond do
      {:ok, %Clock{} = clock} ->
        with {:ok, %Clock{} = clock} <- Time.update_clock(clock, %{status: true, time: time}) do
          conn
          |> put_status(:ok)
          |> render("show.json", clock: clock)
        end

      _ ->
        conn
        |> create(%{userID: user_id, clock: %{status: true, time: time}})
    end
  end

  def clock(conn, %{"userID" => user_id, "clock" => clock_params}) do
    clock_cond = Time.get_clock_by_user_id(user_id)

    IO.puts("No match")
    IO.inspect(clock_params)

    case clock_cond do
      {:ok, %Clock{} = clock} ->
        with {:ok, %Clock{} = clock} <- Time.update_clock(clock, clock_params) do
          conn
          |> put_status(:ok)
          |> render("show.json", clock: clock)
        end

      _ ->
        conn
        |> create(%{userID: user_id, clock: clock_params})
    end
  end

  def create(conn, %{:userID => user_id, :clock => clock_params}) do
    clock_params = Map.merge(%{user_id: user_id}, key_to_atom(clock_params))

    with {:ok, %Clock{} = clock} <- Time.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> render("show.json", working_time: clock)
    end
  end
end
