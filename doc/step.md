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

For query we require Ecto.Schema so
add plate_slate/menu/item.ex (this is the one that is analogus to DB)
Our :menu_items field doesn’t actually build the list of menu items yet. To do that, we have to retrieve the data for the field. GraphQL refers to this as res- olution, and it’s done by defining a resolver for our field.

(Items is for Ecto Schema and items is for table name)
mix phx.gen.schema Items items (to create migrations for DB which will be similar to Ecto.Schema)
add the fields 
mix ecto.migrate 