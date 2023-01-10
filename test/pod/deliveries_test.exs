defmodule Pod.DeliveriesTest do
  use Pod.DataCase

  alias Pod.Deliveries

  describe "deliveries" do
    alias Pod.Deliveries.Delivery

    import Pod.DeliveriesFixtures

    @invalid_attrs %{address: nil, contact: nil, customer: nil, deliver_date: nil, delivery_number: nil, image: nil, phone: nil, post_code: nil, signature: nil}

    test "list_deliveries/0 returns all deliveries" do
      delivery = delivery_fixture()
      assert Deliveries.list_deliveries() == [delivery]
    end

    test "get_delivery!/1 returns the delivery with given id" do
      delivery = delivery_fixture()
      assert Deliveries.get_delivery!(delivery.id) == delivery
    end

    test "create_delivery/1 with valid data creates a delivery" do
      valid_attrs = %{address: "some address", contact: "some contact", customer: "some customer", deliver_date: ~D[2022-12-20], delivery_number: 42, image: "some image", phone: "some phone", post_code: "some post_code", signature: "some signature"}

      assert {:ok, %Delivery{} = delivery} = Deliveries.create_delivery(valid_attrs)
      assert delivery.address == "some address"
      assert delivery.contact == "some contact"
      assert delivery.customer == "some customer"
      assert delivery.deliver_date == ~D[2022-12-20]
      assert delivery.delivery_number == 42
      assert delivery.image == "some image"
      assert delivery.phone == "some phone"
      assert delivery.post_code == "some post_code"
      assert delivery.signature == "some signature"
    end

    test "create_delivery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_delivery(@invalid_attrs)
    end

    test "update_delivery/2 with valid data updates the delivery" do
      delivery = delivery_fixture()
      update_attrs = %{address: "some updated address", contact: "some updated contact", customer: "some updated customer", deliver_date: ~D[2022-12-21], delivery_number: 43, image: "some updated image", phone: "some updated phone", post_code: "some updated post_code", signature: "some updated signature"}

      assert {:ok, %Delivery{} = delivery} = Deliveries.update_delivery(delivery, update_attrs)
      assert delivery.address == "some updated address"
      assert delivery.contact == "some updated contact"
      assert delivery.customer == "some updated customer"
      assert delivery.deliver_date == ~D[2022-12-21]
      assert delivery.delivery_number == 43
      assert delivery.image == "some updated image"
      assert delivery.phone == "some updated phone"
      assert delivery.post_code == "some updated post_code"
      assert delivery.signature == "some updated signature"
    end

    test "update_delivery/2 with invalid data returns error changeset" do
      delivery = delivery_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_delivery(delivery, @invalid_attrs)
      assert delivery == Deliveries.get_delivery!(delivery.id)
    end

    test "delete_delivery/1 deletes the delivery" do
      delivery = delivery_fixture()
      assert {:ok, %Delivery{}} = Deliveries.delete_delivery(delivery)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_delivery!(delivery.id) end
    end

    test "change_delivery/1 returns a delivery changeset" do
      delivery = delivery_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_delivery(delivery)
    end
  end
end
