defmodule TeacherWeb.MovieController do
  use Teacher.Web, :controller

  alias TeacherWeb.Movie

  def index(conn, params) do
    year = get_in(params, ["search", "released_after"])
    genre = get_in(params, ["search", "genre"])
    movies = Movie
             |> Movie.released_after(year)
             |> Movie.by_genre(genre)
             |> Repo.all()
    genres = Movie
             |> Movie.all_genres()
             |> Repo.all()
    render(conn, "index.html", movies: movies, genres: genres)
  end

  def new(conn, _params) do
    changeset = Movie.changeset(%Movie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movie" => movie_params}) do
    changeset = Movie.changeset(%Movie{}, movie_params)

    case Repo.insert(changeset) do
      {:ok, _movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: movie_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Repo.get!(Movie, id)
    render(conn, "show.html", movie: movie)
  end

  def edit(conn, %{"id" => id}) do
    movie = Repo.get!(Movie, id)
    changeset = Movie.changeset(movie)
    render(conn, "edit.html", movie: movie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Repo.get!(Movie, id)
    changeset = Movie.changeset(movie, movie_params)

    case Repo.update(changeset) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: movie_path(conn, :show, movie))
      {:error, changeset} ->
        render(conn, "edit.html", movie: movie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Repo.get!(Movie, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: movie_path(conn, :index))
  end
end
