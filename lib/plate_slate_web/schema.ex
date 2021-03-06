defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.MenuTypes

  scalar :date do 
    parse fn input ->
      case Date.from_iso8601(input.value) do 
        {:ok, date} -> {:ok, date}
        _ -> :error
      end 
    end

    serialize fn date -> 
      Date.to_iso8601(date) 
    end 
  end

  scalar :decimal do 
    parse fn
      %{value: value}, _ -> 
        Decimal.parse(value)
      _, _ ->
        :error
    end
    serialize &to_string/1
  end

  enum :sort_order do 
    value :asc
    value :desc
  end
  
  @desc "The list of available items on the menu"
  query do
    import_fields :menu_queries
  end

  mutation do
    import_fields :menu_create
  end

end
