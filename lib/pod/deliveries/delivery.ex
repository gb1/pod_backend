defmodule Pod.Deliveries.Delivery do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pod.Items.Item

  schema "deliveries" do
    field :address, :string
    field :contact, :string
    field :customer, :string
    field :deliver_date, :date
    field :delivery_number, :string
    field :image, :binary
    field :phone, :string
    field :post_code, :string
    field :signature, :binary
    has_many :delivery_items, Item

    timestamps()
  end

  @doc false
  def changeset(delivery, attrs) do
    delivery
    |> cast(attrs, [
      :delivery_number,
      :deliver_date,
      :customer,
      :address,
      :contact,
      :image,
      :signature,
      :phone,
      :post_code
    ])
    |> validate_required([
      :delivery_number,
      :deliver_date,
      :customer,
      :address
    ])
  end
end
