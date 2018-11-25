using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Swither : MonoBehaviour
{
	[SerializeField]
	private GameObject[] targets;

	private int index = 0;

	void Start()
	{
		SetVisible();
	}
	
	void Update ()
	{
		if (Input.GetKeyDown(KeyCode.LeftArrow))
		{
			index = Mathf.Clamp(index - 1, 0, targets.Length - 1);
			SetVisible();
		}
		else if (Input.GetKeyDown(KeyCode.RightArrow))
		{
			index = Mathf.Clamp(index + 1, 0, targets.Length - 1);
			SetVisible();
		}
	}

	void SetVisible()
	{
		for (var i = 0; i < targets.Length; i++)
		{
			targets[i].SetActive(i == index);
		}
	}
}
