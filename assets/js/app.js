// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"


let Hooks = {}
Hooks.Map = {
    mounted() {

        var map = L.map('map').setView([52.946671, -1.040540], 6);
        // var markers = [];
        var markerGroup = L.layerGroup().addTo(map);

        this.handleEvent("track", (data) => {
            markerGroup.clearLayers();
            data.drivers.data.forEach( driver => {
                var marker = L.marker([driver.lat, driver.lng], {title: driver.name}).addTo(markerGroup);
                marker.bindPopup(`<b>Driver ${driver.name}</b>`).openPopup();
            });
            // console.log("updating drivers...");
            // markers.forEach(marker => map.removeLayer(marker));
            // map.invalidateSize();
            // markers = [];
            
            // data.drivers.data.forEach( driver => {
            //     var marker = L.marker([driver.lat, driver.lng], {title: driver.name}).addTo(map);
            //     marker.bindPopup(`<b>Driver ${driver.name}</b>`).openPopup();
            //     markers.push(marker);
            // });

            // redraw leaflet map
            // map.invalidateSize();

            // L.layerGroup(markers).addLayer()
        });

        
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
    }
}


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


