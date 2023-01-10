defmodule PodWeb.DeliveryControllerTest do
  use PodWeb.ConnCase

  import Pod.DeliveriesFixtures

  @create_attrs %{address: "some address", contact: "some contact", customer: "some customer", deliver_date: ~D[2022-12-20], delivery_number: 42, image: "some image", phone: "some phone", post_code: "some post_code", signature: "some signature"}
  @update_attrs %{address: "some updated address", contact: "some updated contact", customer: "some updated customer", deliver_date: ~D[2022-12-21], delivery_number: 43, image: "some updated image", phone: "some updated phone", post_code: "some updated post_code", signature: "some updated signature"}
  @invalid_attrs %{address: nil, contact: nil, customer: nil, deliver_date: nil, delivery_number: nil, image: nil, phone: nil, post_code: nil, signature: nil}

  describe "index" do
    test "lists all deliveries", %{conn: conn} do
      conn = get(conn, Routes.delivery_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Deliveries"
    end
  end

  describe "new delivery" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.delivery_path(conn, :new))
      assert html_response(conn, 200) =~ "New Delivery"
    end
  end

  describe "create delivery" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.delivery_path(conn, :create), delivery: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.delivery_path(conn, :show, id)

      conn = get(conn, Routes.delivery_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Delivery"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.delivery_path(conn, :create), delivery: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Delivery"
    end
  end

  describe "edit delivery" do
    setup [:create_delivery]

    test "renders form for editing chosen delivery", %{conn: conn, delivery: delivery} do
      conn = get(conn, Routes.delivery_path(conn, :edit, delivery))
      assert html_response(conn, 200) =~ "Edit Delivery"
    end
  end

  describe "update delivery" do
    setup [:create_delivery]

    test "redirects when data is valid", %{conn: conn, delivery: delivery} do
      conn = put(conn, Routes.delivery_path(conn, :update, delivery), delivery: @update_attrs)
      assert redirected_to(conn) == Routes.delivery_path(conn, :show, delivery)

      conn = get(conn, Routes.delivery_path(conn, :show, delivery))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, delivery: delivery} do
      conn = put(conn, Routes.delivery_path(conn, :update, delivery), delivery: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Delivery"
    end
  end

  describe "delete delivery" do
    setup [:create_delivery]

    test "deletes chosen delivery", %{conn: conn, delivery: delivery} do
      conn = delete(conn, Routes.delivery_path(conn, :delete, delivery))
      assert redirected_to(conn) == Routes.delivery_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.delivery_path(conn, :show, delivery))
      end
    end
  end

  defp create_delivery(_) do
    delivery = delivery_fixture()
    %{delivery: delivery}
  end
end
