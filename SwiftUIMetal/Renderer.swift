//
//  Renderer.swift
//  SwiftUIMetal
//
//  Created by Caroline Begbie on 3/4/21.
//

import MetalKit

class Renderer: NSObject {
  let device: MTLDevice
  let commandQueue: MTLCommandQueue
  let pipelineState: MTLRenderPipelineState
  let cubeMesh: MTKMesh
  let depthStencilState: MTLDepthStencilState

  init(metalView: MTKView) {
    guard let device = MTLCreateSystemDefaultDevice() else {
      fatalError("GPU is not supported")
    }
    guard let commandQueue = device.makeCommandQueue() else {
      fatalError("Command Queue not created")
    }
    self.device = device
    self.commandQueue = commandQueue

    let allocator = MTKMeshBufferAllocator(device: device)
    let mdlMesh = MDLMesh(boxWithExtent: [1.2, 1.2, 1.2],
                          segments: [4, 4, 4],
                          inwardNormals: false,
                          geometryType: .triangles,
                          allocator: allocator)
    guard let mesh = try? MTKMesh(mesh: mdlMesh, device: device) else {
      fatalError("Mesh not created")
    }
    self.cubeMesh = mesh
    guard let library = device.makeDefaultLibrary() else {
      fatalError("Library not created")
    }
    let vertexFunction = library.makeFunction(name: "vertexMain")
    let fragmentFunction = library.makeFunction(name: "fragmentMain")

    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
    pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
    pipelineDescriptor.vertexFunction = vertexFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction

    pipelineDescriptor.vertexDescriptor =
      MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)

    guard let pipelineState =
            try? device.makeRenderPipelineState(descriptor: pipelineDescriptor) else {
      fatalError("Pipeline state not created")
    }
    self.pipelineState = pipelineState
    let depthDescriptor = MTLDepthStencilDescriptor()
    depthDescriptor.depthCompareFunction = .less
    depthDescriptor.isDepthWriteEnabled = true
    guard let depthStencilState = device.makeDepthStencilState(descriptor: depthDescriptor) else {
      fatalError("Depth stencil state not created")
    }
    self.depthStencilState = depthStencilState
    super.init()
    metalView.delegate = self
    metalView.device = device
    metalView.depthStencilPixelFormat = .depth32Float
    metalView.clearColor = MTLClearColor(red: 0.93, green: 0.97,
                                         blue: 1.0, alpha: 1)
    mtkView(metalView, drawableSizeWillChange: metalView.bounds.size)
  }
}

extension Renderer: MTKViewDelegate {
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
  }

  func draw(in view: MTKView) {
    guard let commandBuffer = commandQueue.makeCommandBuffer(),
          let renderPassDescriptor = view.currentRenderPassDescriptor,
          let drawable = view.currentDrawable,
          let renderEncoder =
            commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
      return
    }

    renderEncoder.setRenderPipelineState(pipelineState)
    renderEncoder.setDepthStencilState(depthStencilState)


    renderEncoder.setVertexBuffer(cubeMesh.vertexBuffers[0].buffer,
                                  offset: 0, index: 0)
    guard let submesh = cubeMesh.submeshes.first else { return }
    renderEncoder.drawIndexedPrimitives(type: .triangle,
                                        indexCount: submesh.indexCount,
                                        indexType: submesh.indexType,
                                        indexBuffer: submesh.indexBuffer.buffer,
                                        indexBufferOffset: 0)
    renderEncoder.endEncoding()
    commandBuffer.present(drawable)
    commandBuffer.commit()
  }
}
