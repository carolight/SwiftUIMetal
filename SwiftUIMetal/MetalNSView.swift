//
//  MetalView.swift
//  TestMetal
//
//  Created by Caroline Begbie on 14/3/21.
//

import SwiftUI
import MetalKit

struct MetalNSView: View {
  @State private var metalView = MTKView()
  @State private var renderer: Renderer?

  var body: some View {
    MetalViewRepresentable(metalView: $metalView)
      .onAppear {
        renderer = Renderer(metalView: metalView)
      }
  }
}

struct MetalViewRepresentable: NSViewRepresentable {
  @Binding var metalView: MTKView

  func makeNSView(context: Context) -> some NSView {
    metalView
  }

  func updateNSView(_ uiView: NSViewType, context: Context) {
  }
}

struct MetalView_Previews: PreviewProvider {
  static var previews: some View {
    MetalNSView()
  }
}
