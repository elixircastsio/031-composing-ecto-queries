defmodule TeacherWeb.PageController do
  use Teacher.Web, :controller

  def about(conn, _params) do
    render(conn, "about.html")
  end
end
