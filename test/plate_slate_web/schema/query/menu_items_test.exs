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

	@query_variable """
		query ($term: String) {
  	menuItems(matching: $term) {
    	name
		} 
	}
	"""
	@variables %{"term" => "Tea"}

	@query_sort """ 
	{
  	menuItems(order: DESC) {
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
					%{"name" => "Palak Paneer"},
					%{"name" => "Roti"},
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

	test "menuItems field filters by name when using a variable" do
		conn = build_conn()
		response = get(conn, "/api", query: @query_variable, variables: @variables) 
		assert json_response(response, 200) == %{
			"data" => %{ 
				"menuItems" => [
					%{"name" => "Tea"}
				]
			} 
		}
	end


	test "menuItems field returns items descending using literals" do
		response = get(build_conn(), "/api", query: @query_sort) 
		assert %{
			"data" => %{"menuItems" => [
				%{"name" => "Tea"} | _]
			} 
		} = json_response(response, 200)
	end

end