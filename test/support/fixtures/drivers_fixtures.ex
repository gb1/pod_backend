defmodule Pod.DriversFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pod.Drivers` context.
  """

  @doc """
  Generate a driver.
  """
  def driver_fixture(attrs \\ %{}) do
    {:ok, driver} =
      attrs
      |> Enum.into(%{
        current_delivery: "some current_delivery",
        lat: 120.5,
        lng: 120.5,
        name: "some name"
      })
      |> Pod.Drivers.create_driver()

    driver
  end
end
