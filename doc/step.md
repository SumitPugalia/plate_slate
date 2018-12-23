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

Add the lib/plate_slate/seeds.ex for ExUnit Seeding

Separate the resolver module.(plate_slate_web/resolvers/)
and the business logic (plate_slate/menu/)

`In general, a resolver’s job is to mediate between the input that a user sends to our GraphQL API and the business logic that needs to be called to service their request. As your schema gets more complex, you’ll be glad you made space in the overall architecture of your application to keep your resolver and domain business logic separate.`

Add tests..
## We can use GET/POST, both works fine :)

Add Enum type in schema for ordering the result.

We’re providing the order as DESC, and without quotes. By convention, enum values are passed in all uppercase letters.

Mixed in with other arguments that we add to the field, this can quickly become a hodgepodge of various flags and options that would be better organized into related groupings. GraphQL gives us a tool to do this: input object types.

add nonnull macro for required data
