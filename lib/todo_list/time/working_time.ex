defmodule TodoList.Time.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :user, TodoList.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> validate_datetime
  end

  defp validate_datetime(working_time, opts \\ []) do
    {_, start_date} = fetch_field(working_time, :start)
    {_, end_date} = fetch_field(working_time, :end)
    allow_equal = Keyword.get(opts, :allow_equal, true)

    if compare(start_date, end_date, allow_equal) do
      working_time
    else
      mes = message(opts, "End time must be greater or equal to Start time.")
      add_error(working_time, :end, mes)
    end
  end

  defp message(opts, field \\ :message, message) do
    Keyword.get(opts, field, message)
  end

  defp compare(f, t, true), do: f <= t
  defp compare(f, t, false), do: f < t
end
