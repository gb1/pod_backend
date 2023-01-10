defmodule PodWeb.DeliveryController do
  use PodWeb, :controller

  alias Pod.Deliveries
  alias Pod.Deliveries.Delivery
  alias Pod.Items
  alias Pod.Items.Item
  alias Pod.Repo

  def deliveries(conn, _params) do
    deliveries = Deliveries.list_deliveries()
    render(conn, "index.json", deliveries: deliveries)
  end

  def index(conn, _params) do
    deliveries = Deliveries.list_deliveries()
    render(conn, "index.html", deliveries: deliveries)
  end

  def new(conn, _params) do
    changeset = Deliveries.change_delivery(%Delivery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"delivery" => delivery_params}) do
    case Deliveries.create_delivery(delivery_params) do
      {:ok, delivery} ->
        conn
        |> put_flash(:info, "Delivery created successfully.")
        |> redirect(to: Routes.delivery_path(conn, :show, delivery))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    delivery =
      id
      |> Deliveries.get_delivery!()
      |> Repo.preload([:delivery_items])

    changeset = Item.changeset(%Item{}, %{delivery_id: id})

    render(conn, "show.html", delivery: delivery, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    delivery = Deliveries.get_delivery!(id)
    changeset = Deliveries.change_delivery(delivery)
    render(conn, "edit.html", delivery: delivery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "delivery" => delivery_params}) do
    delivery = Deliveries.get_delivery!(id)

    case Deliveries.update_delivery(delivery, delivery_params) do
      {:ok, delivery} ->
        conn
        |> put_flash(:info, "Delivery updated successfully.")
        |> redirect(to: Routes.delivery_path(conn, :show, delivery))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", delivery: delivery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    delivery = Deliveries.get_delivery!(id)
    {:ok, _delivery} = Deliveries.delete_delivery(delivery)

    conn
    |> put_flash(:info, "Delivery deleted successfully.")
    |> redirect(to: Routes.delivery_path(conn, :index))
  end

  def add_item(conn, %{"item" => item_params, "delivery_id" => delivery_id}) do
    delivery =
      delivery_id
      |> Deliveries.get_delivery!()
      |> Repo.preload([:delivery_items])

    IO.puts("adding item")

    case Deliveries.add_item(delivery_id, item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Added Delivery Item!")
        |> redirect(to: Routes.delivery_path(conn, :show, delivery))

      {:error, _error} ->
        conn
        |> put_flash(:error, "Oops! Couldn't add Item!")
        |> redirect(to: Routes.delivery_path(conn, :show, delivery))
    end
  end
end
