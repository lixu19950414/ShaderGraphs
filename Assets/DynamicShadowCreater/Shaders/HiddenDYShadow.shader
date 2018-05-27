Shader "Hidden/HiddenDYShadow"
{
	Properties
	{

	}

	SubShader
	{
		Cull Back ZWrite On
		Pass
		{
			Tags
			{
				"DYShadow" = "True"
			}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float depth : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
			
			float _DYShadowBias;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.depth = COMPUTE_DEPTH_01 + _DYShadowBias;
				return o;
			}

			half4 frag (v2f i) : SV_Target
			{
				return EncodeFloatRGBA(i.depth);
			}
			ENDCG
		}
	}
}
