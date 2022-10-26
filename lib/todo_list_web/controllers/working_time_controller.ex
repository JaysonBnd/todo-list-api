defmodule TodoListWeb.WorkingTimeController do
  use TodoListWeb, :controller

  alias TodoList.Time
  alias TodoList.Time.WorkingTime

  action_fallback TodoListWeb.FallbackController

  def key_to_atom(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      {key, value}, acc when is_binary(key) -> Map.put(acc, String.to_existing_atom(key), value)
    end)
  end

  def show(conn, %{"userID" => user_id, "start" => start_time, "end" => end_time}) do
    workingtimes = Time.get_working_time_by_user_id(user_id, start_time, end_time)

    conn
    |> put_status(:ok)
    |> render("index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"userID" => user_id, "start" => start_time}) do
    workingtimes = Time.get_working_time_by_user_id(user_id, start_time)

    conn
    |> put_status(:ok)
    |> render("index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"userID" => user_id, "end" => end_time}) do
    workingtimes = Time.get_working_time_by_user_id(user_id, end_time)

    conn
    |> put_status(:ok)
    |> render("index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"userID" => user_id}) do
    workingtimes = Time.get_working_time_by_user_id(user_id)

    conn
    |> put_status(:ok)
    |> render("index.json", workingtimes: workingtimes)
  end

  def show_by_id(conn, %{"userID" => user_id, "id" => id}) do
    working_time = Time.get_working_time_by_id!(user_id, id)

    conn
    |> put_status(:ok)
    |> render("show.json", working_time: working_time)
  end

  def create(conn, %{"userID" => user_id, "working_time" => working_time_params}) do
    working_time_params = Map.merge(%{user_id: user_id}, key_to_atom(working_time_params))

    with {:ok, %WorkingTime{} = working_time} <- Time.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> render("show.json", working_time: working_time)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Time.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           Time.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Time.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Time.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
