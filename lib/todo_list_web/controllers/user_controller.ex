defmodule TodoListWeb.UserController do
  use TodoListWeb, :controller

  alias TodoList.Accounts
  alias TodoList.Accounts.User

  action_fallback TodoListWeb.FallbackController

  def show_by_field(conn, %{"email" => email, "username" => username}) do
    users = Accounts.list_users_by_account(email, username)

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show_by_field(conn, %{"username" => username}) do
    users = Accounts.list_users_by_username(username)

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show_by_field(conn, %{"email" => email}) do
    users = Accounts.list_users_by_email(email)

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show_by_field(conn, _params) do
    users = Accounts.list_users()

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show_by_user_id(conn, %{"userID" => user_id}) do
    user = Accounts.get_user!(user_id)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"userID" => user_id, "user" => user_params}) do
    user = Accounts.get_user!(user_id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => user_id}) do
    user = Accounts.get_user!(user_id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
