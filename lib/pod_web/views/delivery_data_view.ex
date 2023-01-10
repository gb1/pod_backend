defmodule PodWeb.DeliveryDataView do
  use PodWeb, :view
  alias PodWeb.DeliveryDataView

  def render("index.json", %{delivery_data: delivery_data}) do
    %{data: render_many(delivery_data, DeliveryDataView, "delivery_data.json")}
  end

  def render("show.json", %{delivery_data: delivery_data}) do
    %{data: render_one(delivery_data, DeliveryDataView, "delivery_data.json")}
  end

  def render("delivery_data.json", %{delivery_data: delivery_data}) do
    %{
      delivery_number: delivery_data.delivery_number,
      deliver_date: delivery_data.deliver_date,
      customer: delivery_data.customer,
      contact: delivery_data.contact,
      address: delivery_data.address,
      items:
        Enum.map(delivery_data.items, fn item ->
          %{
            delivery_item: item.delivery_item,
            material: item.material,
            quantity: item.quantity,
            description: item.description,
            damages_quantity: item.damages_quantity,
            over_delivery: item.over_delivery,
            short_delivery: item.short_delivery,
            refused_quantity: item.refused_quantity
          }
        end)
    }
  end
end
