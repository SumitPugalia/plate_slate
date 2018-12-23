defmodule PlateSlateWeb.Schema.MenuTypes do 
  use Absinthe.Schema.Notation
  @desc "Filtering options for the menu item list" 
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
  
  object :menu_item do
    field :id, :id, description: "primary id"
    field :name, :string, description: "name of the item"
    field :description, :string, description: "describe the item"
    field :price, :float, description: "price of the item"
    field :added_on, :string, description: "created at"
  end
end