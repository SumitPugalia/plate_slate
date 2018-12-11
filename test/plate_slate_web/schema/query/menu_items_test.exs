defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
	use PlateSlateWeb.ConnCase, async: true

	setup do
		PlateSlate.Seeds.run()
		:ok
	end

	@query """
	{
		menuItems {
			name
		}
	}
	"""

	@query_single """
	{
  	menuItems(matching: "Tea") {
    	name
		} 
	}
	"""
	test "menuItems field returns menu items" do
		conn = build_conn()
		conn = get conn, "/api", query: @query
		assert json_response(conn, 200) == %{
			"data" => %{
				"menuItems" => [
					%{"name" => "Roti"},
					%{"name" => "Palak Paneer"},
					%{"name" => "Tea"}
				]
			}
		}
	end

	test "menuItems field returns menu items filtered by name" do
		conn = build_conn()
		response = get(conn, "/api", query: @query_single)
		assert json_response(response, 200) == %{
			"data" => %{ 
				"menuItems" => [
					%{"name" => "Tea"}
				]
			}
		}
	end
end