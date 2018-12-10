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
