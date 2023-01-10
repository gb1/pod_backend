defmodule PodWeb.DeliveryDataControllerTest do
  use PodWeb.ConnCase

  import Pod.APIFixtures

  alias Pod.API.DeliveryData

  @create_attrs %{
    address: "some address",
    delivery: "some delivery",
    item: "some item",
    quantity: 42
  }
  @update_attrs %{
    address: "some updated address",
    delivery: "some updated delivery",
    item: "some updated item",
    quantity: 43
  }
  @invalid_attrs %{address: nil, delivery: nil, item: nil, quantity: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all delivery_data", %{conn: conn} do
      conn = get(conn, Routes.delivery_data_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create delivery_data" do
    test "renders delivery_data when data is valid", %{conn: conn} do
      conn = post(conn, Routes.delivery_data_path(conn, :create), delivery_data: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.delivery_data_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some address",
               "delivery" => "some delivery",
               "item" => "some item",
               "quantity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.delivery_data_path(conn, :create), delivery_data: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update delivery_data" do
    setup [:create_delivery_data]

    test "renders delivery_data when data is valid", %{conn: conn, delivery_data: %DeliveryData{id: id} = delivery_data} do
      conn = put(conn, Routes.delivery_data_path(conn, :update, delivery_data), delivery_data: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.delivery_data_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "delivery" => "some updated delivery",
               "item" => "some updated item",
               "quantity" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, delivery_data: delivery_data} do
      conn = put(conn, Routes.delivery_data_path(conn, :update, delivery_data), delivery_data: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete delivery_data" do
    setup [:create_delivery_data]

    test "deletes chosen delivery_data", %{conn: conn, delivery_data: delivery_data} do
      conn = delete(conn, Routes.delivery_data_path(conn, :delete, delivery_data))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.delivery_data_path(conn, :show, delivery_data))
      end
    end
  end

  defp create_delivery_data(_) do
    delivery_data = delivery_data_fixture()
    %{delivery_data: delivery_data}
  end
end
