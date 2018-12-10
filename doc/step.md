mix phx.new plate_slate --no-html --no-brunch
mix ecto.create

add 
`
{:absinthe, "~> 1.4"},
{:absinthe_plug, "~> 1.4"},
{:absinthe_ecto, "~> 0.1.3"}, 
{:plug_cowboy, "~> 1.0"}
`
in mix.exs (Dependencies for graphql)

mix deps.get

create plate_slate_web/schema.ex for the Object type(menu_item).
C -> Absinthe.Schema.lookup_type(PlateSlateWeb.Schema, "MenuItem")

The query macro is just like object, but it handles some extra defaults for us that Absinthe expects.
C -> Absinthe.Schema.lookup_type(PlateSlateWeb.Schema, "RootQueryType")

(Items is for Ecto Schema and items is for table name)
mix phx.gen.schema Menu.Items items 
(to create migrations for DB which will be similar to Ecto.Schema)
add the fields in both ecto schema and DB migrations

`Our :menu_items field doesn’t actually build the list of menu items yet. To do that, we have to retrieve the data for the field. GraphQL refers to this as res- olution, and it’s done by defining a resolver for our field.`

mix ecto.migrate (to create table out of the migrations, to be speciific it runs the command from the migrations)
add dummy data in seeds.exs
mix run priv/repo/seeds.exs (to fire commands in seeds.ex)

update the router.ex to expose the endpoints

mix phx.server 
Goto browser hit 0.0.0.0/graphiql
`
{
  menuItems { 
    id
		name
    description
  }
}
`
fire query to get the result...
Once the server is up ,
client can get schema.json by using 
`apollo schema:download --endpoint=http://localhost:4000/api schema.json`
