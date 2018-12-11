defmodule PlateSlate.Menu.Menu do
	alias PlateSlate.{Menu, Repo}
  import Ecto.Query
  def list_items(%{matching: name}) when is_binary(name) do 
  	# query = from t in Menu.Item, where: ilike(t.name, name)
  	# Repo.all(query)
    Menu.Item
    |> where([m], ilike(m.name, ^"%#{name}%"))
    |> Repo.all
  end
  
  def list_items(_) do
    Repo.all(Menu.Item)
  end

end