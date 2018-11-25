Shader "ForLT/Step1"
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

			// 今回はここから先だけ見ればオッケー
			fixed4 frag (v2f_img i) : SV_Target
			{
				// シェーダーよく知らなくても、あ〜何となく赤くなりそうだなぁって感じが伝わると思う
				// return fixed4(0, 1, 0, 1); とすると何色になるかな？
				return fixed4(1, 0, 0, 1);
			}
			ENDCG
		}
	}
}
