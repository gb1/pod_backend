defmodule Pod.Drivers.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drivers" do
    field :current_delivery, :string
    field :lat, :float
    field :lng, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:name, :lat, :lng, :current_delivery])
    |> validate_required([:name, :lat, :lng, :current_delivery])
  end
end
