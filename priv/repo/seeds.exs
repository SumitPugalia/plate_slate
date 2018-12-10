# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PlateSlate.Repo.insert!(%PlateSlate.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
  alias PlateSlate.{Menu.Item, Repo}
  Repo.insert! %Item{
    added_on: Ecto.Date.cast!("2018-04-11"),
    description: "Roti To Eat",
    name: "Roti",
    price: Decimal.from_float(1.5)
  }

  Repo.insert! %Item{
    added_on: Ecto.Date.cast!("2018-04-12"),
    description: "Veg To Eat",
    name: "Palak Paneer",
    price: 15
  }

  Repo.insert! %Item{
    added_on: Ecto.Date.cast!("2018-05-17"),
    description: "Tea To Drink",
    name: "Tea",
    price: Decimal.from_float(3.5)
  }