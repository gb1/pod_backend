defmodule PodWeb.MapLive do
  use PodWeb, :live_view
  alias Pod.Drivers
  alias PodWeb.DriverView

  @impl true
  def mount(_params, _session, socket) do
    IO.puts("MOUNTED")

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Pod.PubSub, "driver_location_updated")
      json = DriverView.render("index.json", %{drivers: Drivers.list_drivers()})
      {:ok, push_event(socket, "track", %{"drivers" => json})}
    else
      {:ok, socket}
    end
  end

  @impl true
  def handle_event("map:click", %{"lat" => lat, "lng" => lng}, socket) do
    IO.inspect("lat: #{lat}, lng: #{lng}")

    json = DriverView.render("index.json", %{drivers: Drivers.list_drivers()})

    {:noreply, push_event(socket, "track", %{"drivers" => json})}
  end

  @impl true
  def handle_info({:driver_location_updated, _id}, socket) do
    json = DriverView.render("index.json", %{drivers: Drivers.list_drivers()})
    IO.puts("UPDATING DRIVERS LOCATIONS")
    {:noreply, push_event(socket, "track", %{"drivers" => json})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.6.0/dist/leaflet.css"
    integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
    crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.6.0/dist/leaflet.js"
    integrity="sha512-gZwIG9x3wUXg2hdXF6+rVkLF/0Vi9U8D2Ntg4Ga5I5BZpVkVxlJWbSQtXPSiUTtC0TjtGOmxa1AJPuV0CPthew=="
    crossorigin=""></script>

    <div class="container">
      <div class="row">
        <div class="col">
          <div id="map" style="height: 85vh; width: 100vw" phx-hook="Map"></div>
        </div>
      </div>
    </div>
    """
  end
end
