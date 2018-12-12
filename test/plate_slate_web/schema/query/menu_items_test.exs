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

	@query_invalid """ 
	{
  	menuItems(matching: 123) {
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

	test "menuItems field returns errors when using a bad value" do
		conn = build_conn()
		response = get(conn, "/api", query: @query_invalid) 
		
		assert %{"errors" => [
			%{"message" => message}
		]} = json_response(response, 200) # check how to send this as 400..
		assert message == "Argument \"matching\" has invalid value 123."
	end
end