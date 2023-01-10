defmodule Pod.Repo.Migrations.CreateDeliveries do
  use Ecto.Migration

  def change do
    create table(:deliveries) do
      add :delivery_number, :string
      add :deliver_date, :date
      add :customer, :string
      add :address, :text
      add :contact, :string
      add :image, :binary
      add :signature, :binary
      add :phone, :string
      add :post_code, :string

      timestamps()
    end
  end
end
