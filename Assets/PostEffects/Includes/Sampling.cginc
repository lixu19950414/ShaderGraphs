#ifndef SAMPLING_CGINC
#define SAMPLING_CGINC

// Better, temporally stable box filtering
// [Jimenez14] http://goo.gl/eomGso
// . . . . . . .
// . A . B . C .
// . . D . E . .
// . F . G . H .
// . . I . J . .
// . K . L . M .
// . . . . . . .
half4 DownsampleBox13Tap(sampler2D tex, float2 uv, float2 texelSize)
{
    half4 A = tex2D(tex, uv + texelSize * float2(-1.0, -1.0));
    half4 B = tex2D(tex, uv + texelSize * float2( 0.0, -1.0));
    half4 C = tex2D(tex, uv + texelSize * float2( 1.0, -1.0));
    half4 D = tex2D(tex, uv + texelSize * float2(-0.5, -0.5));
    half4 E = tex2D(tex, uv + texelSize * float2( 0.5, -0.5));
    half4 F = tex2D(tex, uv + texelSize * float2(-1.0,  0.0));
    half4 G = tex2D(tex, uv                                 );
    half4 H = tex2D(tex, uv + texelSize * float2( 1.0,  0.0));
    half4 I = tex2D(tex, uv + texelSize * float2(-0.5,  0.5));
    half4 J = tex2D(tex, uv + texelSize * float2( 0.5,  0.5));
    half4 K = tex2D(tex, uv + texelSize * float2(-1.0,  1.0));
    half4 L = tex2D(tex, uv + texelSize * float2( 0.0,  1.0));
    half4 M = tex2D(tex, uv + texelSize * float2( 1.0,  1.0));

    half2 div = 0.25 * half2(0.5, 0.125);

    half4 o = (D + E + I + J) * div.x;
    o += (A + B + G + F) * div.y;
    o += (B + C + H + G) * div.y;
    o += (F + G + L + K) * div.y;
    o += (G + H + M + L) * div.y;

    return o;
}


// Standard box filtering
half4 DownsampleBox4Tap(sampler2D tex, float2 uv, float2 texelSize)
{
    float4 d = texelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);

    half4 s;
    s =  tex2D(tex, uv + d.xy);
    s += tex2D(tex, uv + d.zy);
    s += tex2D(tex, uv + d.xw);
    s += tex2D(tex, uv + d.zw);

    return s * 0.25;
}

// 9-tap bilinear upsampler (tent filter)
half4 UpsampleTent(sampler2D tex, float2 uv, float2 texelSize, float sampleScale)
{
    float4 d = texelSize.xyxy * float4(1.0, 1.0, -1.0, 0.0) * sampleScale;

    half4 s;
    s =  tex2D(tex, uv - d.xy);
    s += tex2D(tex, uv - d.wy) * 2.0;
    s += tex2D(tex, uv - d.zy);

    s += tex2D(tex, uv + d.zw) * 2.0;
    s += tex2D(tex, uv       ) * 4.0;
    s += tex2D(tex, uv + d.xw) * 2.0;

    s += tex2D(tex, uv + d.zy);
    s += tex2D(tex, uv + d.wy) * 2.0;
    s += tex2D(tex, uv + d.xy);

    return s * 0.0625; //(1.0 / 16 = 0.0625)
}

// Standard box filtering
half4 UpsampleBox(sampler2D tex, float2 uv, float2 texelSize, float sampleScale)
{
    float4 d = texelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0) * (sampleScale * 0.5);

    half4 s;
    s =  tex2D(tex, uv + d.xy);
    s += tex2D(tex, uv + d.zy);
    s += tex2D(tex, uv + d.xw);
    s += tex2D(tex, uv + d.zw);

    return s * 0.25;
}

#endif
