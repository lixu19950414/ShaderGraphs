#ifndef COLOR_CGINC
#define COLOR_CGINC

//
// Quadratic color thresholding
// curve = (threshold - knee, knee * 2, 0.25 / knee)
//

half4 QuadraticThreshold(half4 color, half threshold, half3 curve)
{
    // Pixel brightness
    half br = max(max(color.r, color.g), color.b);

    // Under-threshold part: quadratic curve
    half rq = clamp(br - curve.x, 0.0, curve.y);
    rq = curve.z * rq * rq;

    // Combine and apply the brightness response curve.
    color *= max(rq, br - threshold) / max(br, 0.0001);

    return color;
}

#endif
