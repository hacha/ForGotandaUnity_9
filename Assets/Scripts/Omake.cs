using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class Omake : MonoBehaviour
{
	[SerializeField]
	Material mat;

	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		if (mat == null) {
			return;
		}
		Graphics.Blit(src, dst, mat);
	}
}
