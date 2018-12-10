defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlate.{Menu, Repo}

  @desc "The list of available items on the menu"
  query do
  	field :menu_items, list_of(:menu_item) do
      resolve fn _, _, _ -> {:ok, Repo.all(Menu.Item)} end
    end
  end

  object :menu_item do
    field :id, :id, description: "primary id"
    field :name, :string, description: "name of the item"
    field :description, :string, description: "describe the item"
    field :price, :string, description: "price of the item"
    field :added_on, :string, description: "created at"
  end
end
