defmodule PlateSlate.Items do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do

    timestamps()
  end

  @doc false
  def changeset(items, attrs) do
    items
    |> cast(attrs, [])
    |> validate_required([])
  end
end
