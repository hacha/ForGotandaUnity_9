Shader "ForLT/Omake"
{
	Properties
	{
		_Tile("Tile", int) = 1.0
	
		_CircleSpeed("CircleSpeed", float) = 0.0
		
		_HueMin("HueMin", Range(0.0, 1.0)) = 0.0
		_HueMax("HueMax", Range(0.0, 1.0)) = 1.0
		_Saturation("Saturation", float) = 1.0
		_Value("Value", float) = 1.0
		
		_ToneBase("ToneBase", float) = 4.0

		_Param1("Param1", float) = 0.0
		_Param2("Param2", float) = 0.0
		_Param3("Param3", float) = 0.0
		_Param4("Param4", float) = 0.0

		// コントローラーのスライダーがまだ余ってたので、追加で適当にパラメータを突っ込む
		_CircleSize("CircleSize", float) = 0.0
		_Param4("Param5", float) = 0.0
		_Param6("Param6", float) = 0.0
		_Param7("Param7", float) = 0.0

		_Test("Test", float) = 0.0
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

			int _Tile;
			float _CircleSpeed;
			float _HueMin, _HueMax, _Saturation, _Value;
			float _ToneBase, _ToneSpeed, _ToneMove;
			float _Param1, _Param2, _Param3, _Param4, _Param5;
			float _CircleSize, _Param6, _Param7;
			float _Test;
			
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
				float2 pos = i.pos.xy / _ScreenParams.xy;
				float rate = _ScreenParams.x / _ScreenParams.y;

				// なんとなく歪ませる
				pos.y += sin((i.uv.x - 0.5 + _Param6 * _Time.x) * _Param5) * _Param7;
				pos.x += sin((pos.y - 0.5 + _Param6 * _Time.x) * _Param5) * _Param7 * 0.2;

				// 0.0〜1.0 の範囲を 0.0〜_Tile の範囲にした上で、再度 0.0〜1.0 に押し込める
				pos.x = frac(pos.x * _Tile);
				pos.y = frac(pos.y * _Tile);

				// 0.0〜1.0 の範囲の pos を -1.0〜1.0 の範囲になるよう変換
				pos = pos * 2.0 - 1.0;
				pos.x *= rate;

				// 円を描く
				float c = 1.0 - length(pos);
				// 円のサイズをいじる
				c *= _CircleSize;

				// 時間経過で値を変える
				c = frac(c + _Time.x * _CircleSpeed);
				
				// 正円だとグッと来ないので、ちょっと変形させる
				c += cos(pos.x * pos.y) * _Param1;
				// 更に適当に足したり引いたりしてみちゃったりなんか
				c += abs(0.5 - i.uv.x) * _Param2;
				
				// 値の範囲を広げておいて、小数点以下切り捨てて、元の範囲内に収める
				c = floor(c * _ToneBase) / _ToneBase;
				
				// Hueの値の範囲を_FueMin～_FueMaxに絞る
				float hue = _HueMin + fmod(c, (_HueMax - _HueMin));
				
				// 階調削った上からまた値を重ねると、グラデーションがちょっと乗る
				hue += cos(pos.x * pos.y * _Param3) * _Param4;

				// 色指定をHSVのHだけ動かすとめっちゃカラフル
				fixed4 ret = hsv2rgb(hue, _Saturation, _Value);
				return ret;
			}
			ENDCG
		}
	}
}
