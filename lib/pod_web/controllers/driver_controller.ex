defmodule PodWeb.DriverController do
  use PodWeb, :controller

  alias Pod.Drivers
  alias Pod.Drivers.Driver

  action_fallback PodWeb.FallbackController

  def index(conn, _params) do
    drivers = Drivers.list_drivers()
    render(conn, "index.json", drivers: drivers)
  end

  def create(conn, %{"driver" => driver_params}) do
    with {:ok, %Driver{} = driver} <- Drivers.create_driver(driver_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.driver_path(conn, :show, driver))
      |> render("show.json", driver: driver)
    end
  end

  def show(conn, %{"id" => id}) do
    driver = Drivers.get_driver!(id)
    render(conn, "show.json", driver: driver)
  end

  def update(conn, %{"id" => id, "driver" => driver_params}) do
    IO.puts("UPDATE DRIVER")
    IO.inspect(id)
    IO.inspect(driver_params)

    driver = Drivers.get_driver!(id)

    with {:ok, %Driver{} = driver} <- Drivers.update_driver(driver, driver_params) do
      render(conn, "show.json", driver: driver)
    end

    Phoenix.PubSub.broadcast(
      Pod.PubSub,
      "driver_location_updated",
      {:driver_location_updated, id}
    )
  end

  def delete(conn, %{"id" => id}) do
    driver = Drivers.get_driver!(id)

    with {:ok, %Driver{}} <- Drivers.delete_driver(driver) do
      send_resp(conn, :no_content, "")
    end
  end
end
