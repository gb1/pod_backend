defmodule PodWeb.DeliveryDataController do
  use PodWeb, :controller

  alias Pod.Deliveries

  action_fallback PodWeb.FallbackController

  def index(conn, _params) do
    delivery_data = Deliveries.get_all_deliveries_and_items()
    render(conn, "index.json", delivery_data: delivery_data)
  end

  # def show(conn, %{"id" => id}) do
  #   delivery_data = API.get_delivery_data!(id)
  #   render(conn, "show.json", delivery_data: delivery_data)
  # end
end
