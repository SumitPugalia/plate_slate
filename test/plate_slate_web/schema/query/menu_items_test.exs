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
  	menuItems(filter: {name: "Tea"}) {
    	name
		} 
	}
	"""

	@query_invalid """ 
	{
  	menuItems(filter: {name: 123}) {
    	name
		} 
	}
	"""

	@query_variable """
		query ($term: String) {
  	menuItems(filter: $term) {
    	name
		} 
	}
	"""
	@variables %{"term" => %{:name => "Tea"}}

	@query_sort """ 
	{
  	menuItems(order: DESC) {
    	name
		} 
	}
	"""
	
	@query_new """
	query ($filter: MenuItemFilter!) {
  	menuItems(filter: $filter) {
    	name
		} 
	}
	"""
	@variables_new %{filter: %{"name" => "Tea"}} 

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
		
		assert message == "Argument \"filter\" has invalid value {name: 123}.\nIn field \"name\": Expected type \"String\", found 123."
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

	test "menuItems field returns menuItems, filtering with a variable" do
		response = get(build_conn(), "/api", query: @query_new, variables: @variables_new)
		assert %{"data" => %{"menuItems" => [%{"name" => "Tea"}]} } == json_response(response, 200)
	end

	@query_with_date """
		query ($filter: MenuItemFilter!) {
	    menuItems(filter: $filter) {
	      name
				addedOn 
			}
		}
	"""
	@variables_with_date %{filter: %{"addedBefore" => "2018-04-11"}} 
	test "menuItems filtered by custom scalar" do
		response = get(build_conn(), "/api", query: @query_with_date, variables: @variables_with_date) 
		assert %{
			"data" => %{
			"menuItems" => [%{"name" => "Roti", "addedOn" => "2018-04-11"}]
       }
     } == json_response(response, 200)
	end

	@variables %{filter: %{"addedBefore" => "not-a-date"}} 
	test "menuItems filtered by custom scalar with error" do
		response = get(build_conn(), "/api", query: @query_with_date, variables: @variables)
		assert %{"errors" => [%{"locations" => [
			%{"column" => 0, "line" => 2}], "message" => message}
	  ]} = json_response(response, 200)
		expected = """
			Argument "filter" has invalid value $filter.
			In field "addedBefore": Expected type "Date", found "not-a-date".\
			"""
		assert expected == message
	end

end