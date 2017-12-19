defmodule TeacherWeb.Movie do
  use Teacher.Web, :model

  schema "movies" do
    field :title, :string
    field :summary, :string
    field :year, :string
    field :genre, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :summary, :year, :genre])
    |> validate_required([:title, :summary, :year, :genre])
  end

  def all_genres(query) do
    from movie in query,
    distinct: movie.genre,
    select: movie.genre
  end

  def by_genre(query, genre) when is_nil(genre) or byte_size(genre) == 0 do
    query
  end
  def by_genre(query, genre) do
    from movie in query,
    where: movie.genre == ^genre
  end


  def released_after(query, year) when is_nil(year) or byte_size(year) == 0 do
    query
  end
  def released_after(query, year) do
    from movie in query,
    where: movie.year >= ^year
  end

end
