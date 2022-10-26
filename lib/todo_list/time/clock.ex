defmodule TodoList.Time.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime, default: nil
    belongs_to :user, TodoList.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:status, :user_id])
    |> validate_status_time
  end

  defp validate_status_time(clock) do
    {_, status} = fetch_field(clock, :status)

    time =
      case fetch_change(clock, :time) do
        {:ok, t} -> t
        :error -> nil
      end

    IO.inspect({status, time})

    clock =
      case {status, is_nil(time)} do
        {false, true} ->
          IO.puts("1")
          clock

        {true, false} ->
          IO.puts("2")
          clock

        {true, _} ->
          IO.puts("3")
          mes = message([], "Time must be set when clock_in.")
          add_error(clock, :time, mes)

        {false, _} ->
          IO.puts("4")
          mes = message([], "Time must be null when clock_out.")
          add_error(clock, :time, mes)
      end

    IO.inspect(clock.valid?)
    clock
  end

  defp message(opts, field \\ :message, message) do
    Keyword.get(opts, field, message)
  end
end
