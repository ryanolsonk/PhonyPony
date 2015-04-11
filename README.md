![PhonyPony Logo](https://raw.githubusercontent.com/ryanolsonk/PhonyPony/master/PhonyPony/PhonyPony/Images.xcassets/AppIcon.appiconset/phony-pony-icon%402x.png)

# PhonyPony 📱🐴
[PonyDebugger](https://github.com/square/PonyDebugger) as an app on your phone.

![PhonyPony Demo](https://s3.amazonaws.com/f.cl.ly/items/1d0k043Y0B1H163J1y04/phony-pony.gif)

# Caveats
iOS isn't particularly keen on having apps run in the background. To get around this, the PhonyPony app declares itself as a VOIP app and marks the sockets it uses accordingly. This works for keeping PhonyPony running, but your own app will likely get paused or killed pretty soon after entering the background. If you are actually interested in using PonyDebugger directly on your device, there's a different approach described below.

# Actual Usage
Having PhonyPony as a separate app suffers from backgrounding issues, but you can also run PhonyPony right inside your own app.

# Testimonials
“PhonyPony is an exceptionally bad idea which could only have originated in California.” – Dijkstra
