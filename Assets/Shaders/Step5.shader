Shader "ForLT/Step5"
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

			// HSVからRGBに変換
			fixed4 hsv2rgb(float h, float s, float v)
			{
				// 細かい式はあまり気にしなくていい
				// というより、自分もよく分からん
				fixed4 t = fixed4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
				fixed4 p = abs(frac(fixed4(h, h, h, 1) + t) * 6.0 - fixed4(t.w, t.w, t.w, 1));
				return v * lerp(fixed4(t.x, t.x, t.x, 1), clamp(p - fixed4(t.x, t.x, t.x, 1), 0.0, 1.0), s);
			}

			fixed4 frag (v2f_img i) : SV_Target
			{
				float2 pos = i.uv;
				
				// 0.0〜1.0 の範囲の pos を -1.0〜1.0 の範囲になるよう変換
				pos = pos * 2.0 - 1.0;
				
				// 円を描く
				float c = 1.0 - length(pos);
				
				// 時間経過で値を変える
				c = frac(c + _Time.x * _CircleSpeed);

				// 色指定をHSVにしてHだけ動かすとめっちゃカラフル
				fixed4 ret = hsv2rgb(c, 1.0, 1.0);
				return ret;
			}
			ENDCG
		}
	}
}
