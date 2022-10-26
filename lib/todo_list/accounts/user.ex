defmodule TodoList.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    has_one :clock, TodoList.Time.Clock, on_delete: :delete_all
    has_many :workingtimes, TodoList.Time.WorkingTime, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_format(:email, ~r/\w+[@]\w+[.]\w+/, message: "Not a valid email")
    |> validate_required([:username, :email])
  end
end
