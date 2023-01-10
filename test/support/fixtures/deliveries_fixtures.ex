defmodule Pod.DeliveriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pod.Deliveries` context.
  """

  @doc """
  Generate a delivery.
  """
  def delivery_fixture(attrs \\ %{}) do
    {:ok, delivery} =
      attrs
      |> Enum.into(%{
        address: "some address",
        contact: "some contact",
        customer: "some customer",
        deliver_date: ~D[2022-12-20],
        delivery_number: 42,
        image: "some image",
        phone: "some phone",
        post_code: "some post_code",
        signature: "some signature"
      })
      |> Pod.Deliveries.create_delivery()

    delivery
  end
end
