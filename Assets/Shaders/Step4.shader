Shader "ForLT/Step4"
{
	Properties
	{
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
				float2 pos = i.uv;
				
				// 0.0〜1.0 の範囲の pos を -1.0〜1.0 の範囲になるよう変換
				pos = pos * 2.0 - 1.0;
				
				// 円を描く
				float c = 1.0 - length(pos);
				
				// 時間経過で値が変わるようにする
				// _Time を足し込むだけだといずれ真っ白になるので、fracで0.0〜1.0の間を繰り返すようにする
				c = frac(c + _Time.x * 5.0);

				return fixed4(c, c, c, 1);
			}
			ENDCG
		}
	}
}
