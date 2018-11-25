Shader "ForLT/Step2"
{
	Properties
	{
		_CircleSpeed("CircleSpeed", float) = 0.0
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			fixed4 frag (v2f_img i) : SV_Target
			{
				// i.uv にUV座標の値が入っている
				float c = i.uv.x * i.uv.y;
				return fixed4(c, c, c, 1);
			}
			ENDCG
		}
	}
}
