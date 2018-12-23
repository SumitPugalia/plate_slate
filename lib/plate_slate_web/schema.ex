defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlateWeb.Resolvers
  alias PlateSlate.{Menu, Repo}

  enum :sort_order do 
    value :asc
    value :desc
  end
  
  @desc "Filtering options for the menu item list" 
  input_object :menu_item_filter do
    
    @desc "Matching a name" 
    field :name, :string
    
    @desc "Matching a category name" 
    field :category, :string
    
    @desc "Matching a tag" 
    field :tag, :string
    
    @desc "Priced above a value" 
    field :priced_above, :float
    
    @desc "Priced below a value" 
    field :priced_below, :float
  end

  @desc "The list of available items on the menu"
  query do
    field :menu_items, list_of(:menu_item) do
      # arg :filter, non_null(:menu_item_filter)
      arg :filter, :menu_item_filter
      arg :order, type: :sort_order, default_value: :asc #keyword list way
      resolve &Resolvers.Menu.menu_items/3
    end
  end

  object :menu_item do
    field :id, :id, description: "primary id"
    field :name, :string, description: "name of the item"
    field :description, :string, description: "describe the item"
    field :price, :float, description: "price of the item"
    field :added_on, :string, description: "created at"
  end

end
