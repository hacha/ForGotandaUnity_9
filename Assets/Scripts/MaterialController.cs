using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialController : MonoBehaviour
{
	[SerializeField]
	NanoKontrol2 nk;

	Material mat;

	[SerializeField]
	float SaturationMax, ValueMax, CircleSpeedMax, CircleSizeRate, TileMax, ToneMax;
	[SerializeField]
	float Param1Rate, Param2Rate, Param3Rate, Param4Rate, Param5Rate, Param6Rate, Param7Rate, Param8Rate;
	[SerializeField]
	AudioSource sound;

	const float Slider7Offset = 1.0f;
	const float ToneMin = 2.0f;
	const float TileMin = 1.0f;

	void Start ()
	{
		mat = GetComponent<Renderer>().sharedMaterial;
		nk.valueChangedFunctions.Add (ValueChanged);
		nk.keyPushedFunctions.Add (KeyPushed);
	}

	const float KeyValueMax = 127.0f;

	//キー（スライダー・ノブ）の値が変更された場合に呼び出される関数
	void ValueChanged(string keyName, int keyValue)
	{
		Debug.Log(keyName + ": " + keyValue);
		switch (keyName) {
			case "Slider1" :
				mat.SetFloat("_HueMin", keyValue / KeyValueMax);
				break;
			case "Slider2" :
				mat.SetFloat("_HueMax", keyValue / KeyValueMax);
				break;
			case "Slider3" :
				mat.SetFloat("_CircleSpeed", keyValue / KeyValueMax * CircleSpeedMax);
				break;
			case "Slider4" :
				mat.SetFloat("_Tile", TileMin + (keyValue / KeyValueMax * TileMax));
				break;
			case "Slider5" :
				mat.SetFloat("_Param5", keyValue / KeyValueMax * Param5Rate);
				break;
			case "Slider6" :
				mat.SetFloat("_Param6", keyValue / KeyValueMax * Param6Rate);
				break;
			case "Slider7" :
				mat.SetFloat("_Param7", (Slider7Offset + keyValue) / KeyValueMax * Param7Rate);
				break;
			case "Slider8" :
				sound.volume = keyValue / KeyValueMax;
				break;
			case "Knob1" :
				mat.SetFloat("_Saturation", keyValue / KeyValueMax * SaturationMax);
				break;
			case "Knob2" :
				mat.SetFloat("_Value", keyValue / KeyValueMax * ValueMax);
				break;
			case "Knob3" :
				mat.SetFloat("_CircleSize", keyValue / KeyValueMax * CircleSizeRate);
				break;
			case "Knob4" :
				mat.SetFloat("_ToneBase", Mathf.Lerp(ToneMin, ToneMax, keyValue / KeyValueMax));
				break;
			case "Knob5" :
				mat.SetFloat("_Param1", Mathf.Lerp(-KeyValueMax / 2, KeyValueMax / 2, keyValue / KeyValueMax) * Param1Rate);
				break;
			case "Knob6" :
				mat.SetFloat("_Param2", Mathf.Lerp(-KeyValueMax / 2, KeyValueMax / 2, keyValue / KeyValueMax) * Param2Rate);
				break;
			case "Knob7" :
				mat.SetFloat("_Param3", Mathf.Lerp(-KeyValueMax / 2, KeyValueMax / 2, keyValue / KeyValueMax) * Param3Rate);
				break;
			case "Knob8" :
				mat.SetFloat("_Param4", Mathf.Lerp(-KeyValueMax / 2, KeyValueMax / 2, keyValue / KeyValueMax) * Param4Rate);
				break;
		}
	}

	//キーが押された場合に呼び出される関数
	void KeyPushed(string keyName)
	{
		Debug.Log(keyName);
		// 値をニュートラルな感じにリセットする
		switch (keyName) {
			case "S1" :
				mat.SetFloat("_Saturation", 1.0f);
				break;
			case "S2" :
				mat.SetFloat("_Value", 1.0f);
				break;
			case "S4" :
				mat.SetFloat("_ToneBase", 9999.0f);
				break;
			case "S5" :
				mat.SetFloat("_Param1", 0.0f);
				break;
			case "S6" :
				mat.SetFloat("_Param2", 0.0f);
				break;
			case "S7" :
				mat.SetFloat("_Param3", 0.0f);
				break;
			case "S8" :
				mat.SetFloat("_Param4", 0.0f);
				break;
		}
	}
}
