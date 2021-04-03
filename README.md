# SwiftUIMetal

A very simple example of using Metal with SwiftUI on macOS. It creates a cube and renders it. No lighting or matrices involved.

`Renderer` is the main Metal class.

`MetalNSView` stores an `MTKView` and creates a `Renderer` on first appearance. 

`MetalNSView` creates a `MetalViewRepresentable` which creates a view in which to show the metal view on screen.

iOS would be the same, but with `UI` instead of `NS`.




