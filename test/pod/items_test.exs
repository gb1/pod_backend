defmodule Pod.ItemsTest do
  use Pod.DataCase

  alias Pod.Items

  describe "items" do
    alias Pod.Items.Item

    import Pod.ItemsFixtures

    @invalid_attrs %{damages_quantity: nil, delivery_item: nil, description: nil, material: nil, over_delivery: nil, refused_quantity: nil, short_delivery: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{damages_quantity: 42, delivery_item: 42, description: "some description", material: "some material", over_delivery: 42, refused_quantity: 42, short_delivery: 42}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.damages_quantity == 42
      assert item.delivery_item == 42
      assert item.description == "some description"
      assert item.material == "some material"
      assert item.over_delivery == 42
      assert item.refused_quantity == 42
      assert item.short_delivery == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{damages_quantity: 43, delivery_item: 43, description: "some updated description", material: "some updated material", over_delivery: 43, refused_quantity: 43, short_delivery: 43}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.damages_quantity == 43
      assert item.delivery_item == 43
      assert item.description == "some updated description"
      assert item.material == "some updated material"
      assert item.over_delivery == 43
      assert item.refused_quantity == 43
      assert item.short_delivery == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
