#include <metal_stdlib>
#include <RealityKit/RealityKit.h>

using namespace metal;

[[visible]]
void simpleStretch(realitykit::geometry_parameters params)
{
    // Our vertex point relative to the model's anchor
    float3 localPos = params.geometry().model_position();

    // Sin curve of time * 3
    // 3 is an arbitrary value used to change the speed
    float offsetMult = sin(params.uniforms().time() * 3);
  
      // Only points above the y-axis
    if (localPos.y > 0) {
        params.geometry().set_model_position_offset(
            // offset by starting coordinate * sin(time) result
            float3(localPos.x * offsetMult, 0, localPos.z * offsetMult)
        );
    }
}

[[visible]]
void waveMotion(realitykit::geometry_parameters params)
{
    float xSpeed = 1;
    float zSpeed = 1.1;
    float xAmp = 0.01;
    float zAmp = 0.02;

    float3 localPos = params.geometry().model_position();

    float xPeriod = (sin(localPos.x * 40 + params.uniforms().time() /40) + 3) * 2;
    float zPeriod = (sin(localPos.z * 20 + params.uniforms().time() /13) + 3);

    float xOffset = xAmp * sin(xSpeed * params.uniforms().time() + xPeriod * localPos.x);
    float zOffset = zAmp * sin(zSpeed * params.uniforms().time() + zPeriod * localPos.z);
    params.geometry().set_model_position_offset(
        float3(0, xOffset + zOffset, 0)
    );
}


