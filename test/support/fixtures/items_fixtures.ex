defmodule Pod.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pod.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        damages_quantity: 42,
        delivery_item: 42,
        description: "some description",
        material: "some material",
        over_delivery: 42,
        refused_quantity: 42,
        short_delivery: 42
      })
      |> Pod.Items.create_item()

    item
  end
end
