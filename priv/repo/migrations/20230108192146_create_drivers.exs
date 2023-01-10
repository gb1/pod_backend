defmodule Pod.Repo.Migrations.CreateDrivers do
  use Ecto.Migration

  def change do
    create table(:drivers) do
      add :name, :string
      add :lat, :float
      add :lng, :float
      add :current_delivery, :string

      timestamps()
    end
  end
end
