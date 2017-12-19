defmodule TeacherWeb.MovieView do
  use Teacher.Web, :view

  def released_after_years do
    [1930, 1940, 1950, 1960, 1970, 1980]
  end

end
