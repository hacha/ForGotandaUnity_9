Shader "ForLT/Step4_2"
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
			
			float _CircleSpeed;

			fixed4 frag (v2f_img i) : SV_Target
			{
				float2 pos = i.uv;
				
				// 0.0〜1.0 の範囲の pos を -1.0〜1.0 の範囲になるよう変換
				pos = pos * 2.0 - 1.0;
				
				// 円を描く
				float c = 1.0 - length(pos);
				
				// 時間経過で値が変わるようにする
				// スピードをプロパティ化した
				c = frac(c + _Time.x * _CircleSpeed);
				
				return fixed4(c, c, c, 1);
			}
			ENDCG
		}
	}
}
