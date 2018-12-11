defmodule PlateSlateWeb.Resolvers.Menu do 
  alias PlateSlate.Menu.Menu
  
  def menu_items(_, args, _) do 
    {:ok, Menu.list_items(args)}
  end 
end