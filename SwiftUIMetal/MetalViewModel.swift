//
//  MetalViewModel.swift
//  SwiftUIMetal
//
//  Created by Caroline Begbie on 22/3/2023.
//

import MetalKit

class MetalViewModel: ObservableObject {
  let metalView = MTKView()
  let renderer: Renderer

  @Published var primitiveType: Options = .triangle {
    didSet {
      renderer.setPrimitiveType(primitiveType)
    }
  }

  init() {
    renderer = Renderer(metalView: metalView)
  }
}
