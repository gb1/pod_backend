defmodule Pod.DriversTest do
  use Pod.DataCase

  alias Pod.Drivers

  describe "drivers" do
    alias Pod.Drivers.Driver

    import Pod.DriversFixtures

    @invalid_attrs %{current_delivery: nil, lat: nil, lng: nil, name: nil}

    test "list_drivers/0 returns all drivers" do
      driver = driver_fixture()
      assert Drivers.list_drivers() == [driver]
    end

    test "get_driver!/1 returns the driver with given id" do
      driver = driver_fixture()
      assert Drivers.get_driver!(driver.id) == driver
    end

    test "create_driver/1 with valid data creates a driver" do
      valid_attrs = %{current_delivery: "some current_delivery", lat: 120.5, lng: 120.5, name: "some name"}

      assert {:ok, %Driver{} = driver} = Drivers.create_driver(valid_attrs)
      assert driver.current_delivery == "some current_delivery"
      assert driver.lat == 120.5
      assert driver.lng == 120.5
      assert driver.name == "some name"
    end

    test "create_driver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver(@invalid_attrs)
    end

    test "update_driver/2 with valid data updates the driver" do
      driver = driver_fixture()
      update_attrs = %{current_delivery: "some updated current_delivery", lat: 456.7, lng: 456.7, name: "some updated name"}

      assert {:ok, %Driver{} = driver} = Drivers.update_driver(driver, update_attrs)
      assert driver.current_delivery == "some updated current_delivery"
      assert driver.lat == 456.7
      assert driver.lng == 456.7
      assert driver.name == "some updated name"
    end

    test "update_driver/2 with invalid data returns error changeset" do
      driver = driver_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver(driver, @invalid_attrs)
      assert driver == Drivers.get_driver!(driver.id)
    end

    test "delete_driver/1 deletes the driver" do
      driver = driver_fixture()
      assert {:ok, %Driver{}} = Drivers.delete_driver(driver)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver!(driver.id) end
    end

    test "change_driver/1 returns a driver changeset" do
      driver = driver_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver(driver)
    end
  end
end
