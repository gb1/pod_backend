defmodule PodWeb.DriverControllerTest do
  use PodWeb.ConnCase

  import Pod.DriversFixtures

  alias Pod.Drivers.Driver

  @create_attrs %{
    current_delivery: "some current_delivery",
    lat: 120.5,
    lng: 120.5,
    name: "some name"
  }
  @update_attrs %{
    current_delivery: "some updated current_delivery",
    lat: 456.7,
    lng: 456.7,
    name: "some updated name"
  }
  @invalid_attrs %{current_delivery: nil, lat: nil, lng: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all drivers", %{conn: conn} do
      conn = get(conn, Routes.driver_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create driver" do
    test "renders driver when data is valid", %{conn: conn} do
      conn = post(conn, Routes.driver_path(conn, :create), driver: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.driver_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "current_delivery" => "some current_delivery",
               "lat" => 120.5,
               "lng" => 120.5,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.driver_path(conn, :create), driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update driver" do
    setup [:create_driver]

    test "renders driver when data is valid", %{conn: conn, driver: %Driver{id: id} = driver} do
      conn = put(conn, Routes.driver_path(conn, :update, driver), driver: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.driver_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "current_delivery" => "some updated current_delivery",
               "lat" => 456.7,
               "lng" => 456.7,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, driver: driver} do
      conn = put(conn, Routes.driver_path(conn, :update, driver), driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete driver" do
    setup [:create_driver]

    test "deletes chosen driver", %{conn: conn, driver: driver} do
      conn = delete(conn, Routes.driver_path(conn, :delete, driver))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.driver_path(conn, :show, driver))
      end
    end
  end

  defp create_driver(_) do
    driver = driver_fixture()
    %{driver: driver}
  end
end
