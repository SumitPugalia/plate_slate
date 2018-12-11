defmodule PlateSlate.Seeds do
  alias PlateSlate.{Menu.Item, Repo}
  
  def run do
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
  end
end
  