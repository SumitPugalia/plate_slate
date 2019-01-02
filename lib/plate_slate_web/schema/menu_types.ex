defmodule PlateSlateWeb.Schema.MenuTypes do 
  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Resolvers

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

    @desc "Added to the menu before this date"
    field :added_before, :date
    
    @desc "Added to the menu after this date"
    field :added_after, :date
  end

  input_object :menu_item_input do 
    field :name, non_null(:string) 
    field :description, :string
    field :price, non_null(:decimal) 
  end

  object :menu_item do
    field :id, :id, description: "primary id"
    field :name, :string, description: "name of the item"
    field :description, :string, description: "describe the item"
    field :price, :float, description: "price of the item"
    field :added_on, :string, description: "created at"
  end

  object :menu_queries do
  	field :menu_items, list_of(:menu_item) do
      # arg :filter, non_null(:menu_item_filter)
      arg :filter, :menu_item_filter
      arg :order, type: :sort_order, default_value: :asc #keyword list way
      resolve &Resolvers.Menu.menu_items/3
    end
  end

  object :menu_create do
    field :create_menu_item, :menu_item do
      arg :input, non_null(:menu_item_input) 
      resolve &Resolvers.Menu.create_item/3
    end
  end

end