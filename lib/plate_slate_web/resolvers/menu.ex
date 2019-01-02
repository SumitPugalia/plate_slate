defmodule PlateSlateWeb.Resolvers.Menu do 
  alias PlateSlate.Menu.Menu
  
  def menu_items(_first, args, _last) do 
    {:ok, Menu.list_items(args)}
  end

  def create_item(_, %{input: params}, _) do 
  	case Menu.create_item(params) do
			{:error, _} ->
				{:error, "Could not create menu item"}
			{:ok, _} = success -> 
				IO.inspect success
				success
		end 
	end
end