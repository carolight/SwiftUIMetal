//
//  Shaders.metal
//  SwiftUIMetal
//
//  Created by Caroline Begbie on 22/3/2023.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
  float4 position [[attribute(0)]];
  float3 normal [[attribute(1)]];
};

struct VertexOut {
  float4 position [[position]];
  float3 normal;
  float pointSize [[point_size]];
};

vertex VertexOut vertexMain(const VertexIn in [[stage_in]]) {
  VertexOut out {
    .position = in.position,
    .normal = in.normal,
    .pointSize = 10
  };
  return out;
}

fragment float4 fragmentMain(VertexOut in [[stage_in]]) {
  return float4(0, 0, 1, 1);
}

