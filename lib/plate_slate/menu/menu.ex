defmodule PlateSlate.Menu.Menu do
	alias PlateSlate.{Menu, Repo}
  import Ecto.Query
  # def list_items(%{matching: name}) when is_binary(name) do 
  # 	query = from t in Menu.Item, where: ilike(t.name, ^name)
  # 	Repo.all(query)
  #   # Menu.Item
  #   # |> where([m], ilike(m.name, ^"%#{name}%"))
  #   # |> Repo.all
  # end
  
  # def list_items(_) do
  #   Repo.all(Menu.Item)
  # end

  # def list_items(filters) do 
  #   filters
  #   |> Enum.reduce(Menu.Item, fn 
  #       {_, nil}, query ->
  #         query
  #       {:order, order}, query ->
  #         from q in query, order_by: {^order, :name} 
  #       {:matching, name}, query ->
  #         from q in query, where: ilike(q.name, ^"%#{name}%") 
  #     end)
  #   |> Repo.all
  # end

  def list_items(args) do 
    args
    |> Enum.reduce(Menu.Item, fn 
      {:order, order}, query ->
        query |> order_by({^order, :name}) 
      {:filter, filter}, query ->
        query |> filter_with(filter) 
      end)
    |> Repo.all
  end
  
  defp filter_with(query, filter) do 
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from q in query, where: ilike(q.name, ^"%#{name}%")
      {:priced_above, price}, query ->
        from q in query, where: q.price >= ^price
      {:priced_below, price}, query ->
        from q in query, where: q.price <= ^price
      {:added_after, date}, query ->
        from q in query, where: q.added_on >= ^date
      {:added_before, date}, query ->
        from q in query, where: q.added_on <= ^date

      # {:category, category_name}, query -> 
      #   from q in query,
      #   join: c in assoc(q, :category),
      #   where: ilike(c.name, ^"%#{category_name}%") 
      # {:tag, tag_name}, query ->
      #   from q in query,
      #   join: t in assoc(q, :tags),
      #   where: ilike(t.name, ^"%#{tag_name}%")
    end)
  end

  def create_item(attrs \\ %{}) do 
    %Menu.Item{}
    |> Menu.Item.changeset(attrs)
    |> Repo.insert()
  end
end