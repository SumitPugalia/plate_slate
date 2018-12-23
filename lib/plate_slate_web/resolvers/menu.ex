defmodule PlateSlateWeb.Resolvers.Menu do 
  alias PlateSlate.Menu.Menu
  
  def menu_items(first, args, last) do 
    {:ok, Menu.list_items(args)}
  end 
end