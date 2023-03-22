# SwiftUIMetal

A very simple example of using Metal with SwiftUI on macOS and iOS.

`Renderer` is the main Metal class that creates a cube and renders it. No lighting or matrices involved. 

`MetalView` creates a `MetalViewModel` and creates a `MetalViewRepresentable` which shows the metal view on screen.

`MetalViewModel` stores an `MTKView` and creates a `Renderer` on initialization. 

For passing UI information to the renderer, add the UI element and update a published property in `MetalViewModel`. When this property changes, pass it to `renderer`. The sample shows a segmented control that determines the primitive type to render. You can choose points, line, or triangle.
