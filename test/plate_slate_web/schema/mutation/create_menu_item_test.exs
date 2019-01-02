defmodule PlateSlateWeb.Schema.Mutation.CreateMenuTest do 
  use PlateSlateWeb.ConnCase, async: true
  
  setup do 
    PlateSlate.Seeds.run()
    :ok
  end

  @query """
  mutation ($menuItem: MenuItemInput!) {
    createMenuItem(input: $menuItem) {
      name
      description 
      price 
    }
  }
  """
  test "createMenuItem field creates an item", _ do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Roast beef, caramelized onions, horseradish, ...", 
      "price" => "5.75"
    }
    conn = build_conn()
    conn = post conn, "/api", query: @query, variables: %{"menuItem" => menu_item}
    assert json_response(conn, 200) == %{ 
      "data" => %{
        "createMenuItem" => %{
          "name" => menu_item["name"],
          "description" => menu_item["description"], 
          "price" => menu_item["price"]
        } 
      }
    }
  end

  test "creating a menu item with an existing name fails", _ do
    menu_item = %{
      "name" => "Exist",
      "description" => "Roast beef, caramelized onions, horseradish, ...",
      "price" => "5.75"
    }
    conn = build_conn()
    conn = post conn, "/api", query: @query, variables: %{"menuItem" => menu_item}
    conn = post conn, "/api", query: @query, variables: %{"menuItem" => menu_item}
    assert json_response(conn, 200) == %{ 
      "data" => %{"createMenuItem" => nil}, 
      "errors" => [%{
        "locations" => [%{"column" => 0, "line" => 2}], 
        "message" => "Could not create menu item",
        "details" => %{"name" => ["has already been taken"]}, 
        "path" => ["createMenuItem"]
      }]
    }
  end
end