//
//  MetalView.swift
//  SwiftUIMetal
//
//  Created by Caroline Begbie on 22/3/2023.
//

import SwiftUI
import MetalKit

struct MetalView: View {
  @StateObject var mvm = MetalViewModel()

  var body: some View {
    VStack(alignment: .leading) {
      Picker("Primitive Type", selection: $mvm.primitiveType) {
        Text("Points").tag(Options.point)
        Text("Lines").tag(Options.line)
        Text("Triangles").tag(Options.triangle)
      }
      .pickerStyle(.segmented)
      .fixedSize()
      MetalViewRepresentable(metalView: mvm.metalView)
    }
  }
}

struct MetalView_Previews: PreviewProvider {
  static var previews: some View {
    MetalView()
  }
}

#if os(macOS)
typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
typealias ViewRepresentable = UIViewRepresentable
#endif

struct MetalViewRepresentable: ViewRepresentable {
  let metalView: MTKView

#if os(macOS)
  func makeNSView(context: Context) -> some NSView {
    metalView
  }
  func updateNSView(_ uiView: NSViewType, context: Context) {
    updateMetalView()
  }
#elseif os(iOS)
  func makeUIView(context: Context) -> MTKView {
    metalView
  }

  func updateUIView(_ uiView: MTKView, context: Context) {
    updateMetalView()
  }
#endif

  func updateMetalView() {
  }
}
