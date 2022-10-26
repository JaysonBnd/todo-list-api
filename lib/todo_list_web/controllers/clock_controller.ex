defmodule TodoListWeb.ClockController do
  use TodoListWeb, :controller

  alias TodoList.Time
  alias TodoList.Time.Clock

  action_fallback TodoListWeb.FallbackController

  def show(conn, %{"userID" => userID}) do
    clock = Time.get_clock_by_user_id!(userID)

    case clock do
      [] ->
        conn
        |> render("404.json", %{})
    end

    render(conn, "index.json", clock: clock)
  end

  def clock(conn, %{"userID" => userID, "clock" => clock_params}) do
    clock = Time.get_clock_by_user_id!(userID)

    with {:ok, %Clock{} = clock} <- Time.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end
end
