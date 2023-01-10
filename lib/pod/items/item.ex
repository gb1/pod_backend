defmodule Pod.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :delivery_item, :integer
    field :description, :string
    field :material, :string
    field :quantity, :integer
    field :damages_quantity, :integer, default: 0
    field :over_delivery, :integer, default: 0
    field :refused_quantity, :integer, default: 0
    field :short_delivery, :integer, default: 0
    field :delivery_id, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [
      :delivery_id,
      :delivery_item,
      :description,
      :material,
      :quantity,
      :damages_quantity,
      :over_delivery,
      :short_delivery,
      :refused_quantity
    ])
    |> validate_required([
      :delivery_id,
      :delivery_item,
      :material,
      :description,
      :quantity
    ])
  end
end
