defmodule TodoListWeb.ClockView do
  use TodoListWeb, :view
  alias TodoListWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{
      user_id: clock.user_id,
      id: clock.id,
      time: clock.time,
      status: clock.status
    }
  end
end
