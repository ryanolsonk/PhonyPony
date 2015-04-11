![PhonyPony Logo](https://raw.githubusercontent.com/ryanolsonk/PhonyPony/master/PhonyPony/PhonyPony/Images.xcassets/AppIcon.appiconset/phony-pony-icon%402x.png)

# PhonyPony 📱🐴
Run [PonyDebugger](https://github.com/square/PonyDebugger) entirely on your phone. No computer needed.

![PhonyPony Demo](https://s3.amazonaws.com/f.cl.ly/items/1d0k043Y0B1H163J1y04/phony-pony.gif)

The PonyDebugger project consists of 3 main parts: a client library that you include in your iOS app, a python gateway server that runs on a desktop machine, and Chrome Developer Tools running in a browser. PhonyPony uses an objective-c port of the gateway server and [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer) to bring everything onto your phone. [SVWebViewController](https://github.com/TransitApp/SVWebViewController) is used as an in-app browser to display a bundled version of Chrome Developer Tools.

## Caveats
iOS isn't particularly keen on having apps run in the background. To get around this, the PhonyPony app declares itself as a VOIP app and marks the sockets it uses accordingly. This works for keeping PhonyPony running, but your own app will likely get paused or killed pretty soon after entering the background. This project was more of an experiment than something I think is genuinely useful. However, if you'd really like to use PonyDebugger in-app, you could certainly embed the gateway server in your own app, eliminating the backgrounding issues. Alternatively, check out [FLEX](https://github.com/Flipboard/FLEX) for a project that is dedicated to on-device debugging.

## Testimonials
“PhonyPony is an exceptionally bad idea which could only have originated in California.” – Dijkstra

## Contact
Have questions? Open an issue or contact me [(@ryanolsonk)](http://twitter.com/ryanolsonk) on twitter.
