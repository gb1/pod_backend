defmodule Pod.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :delivery_item, :integer
      add :description, :text
      add :material, :string
      add :quantity, :integer
      add :damages_quantity, :integer
      add :over_delivery, :integer
      add :short_delivery, :integer
      add :refused_quantity, :integer
      add :delivery_id, references(:deliveries, on_delete: :delete_all)

      timestamps()
    end

    create index(:items, [:delivery_id])
  end
end
