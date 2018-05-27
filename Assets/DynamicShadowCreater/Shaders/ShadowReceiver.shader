Shader "ShadowReceiver"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Back ZWrite On ZTest Less

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float depth : TEXCOORD1;
				float2 shadowCoord : TEXCOORD2;
			};

			sampler2D _MainTex;
			float4x4 _DYShadowProj;
			float4x4 _DYShadowWorldToCamera;
			sampler2D _DYShadowTex;
			float _DYShadowOneDivideFar;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;

				float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
				float4 viewPos = mul(_DYShadowWorldToCamera, worldPos);
				o.depth = -(viewPos.z * _DYShadowOneDivideFar);
				float4 projPos = mul(_DYShadowProj, viewPos);
				o.shadowCoord = projPos.xy * 0.5 + 0.5;
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float shadowDepth = DecodeFloatRGBA(tex2D(_DYShadowTex, i.shadowCoord));
				float atten = step(i.depth, shadowDepth);
				fixed4 col = tex2D(_MainTex, i.uv) * atten;
				return col;
			}
			ENDCG
		}
	}
}
