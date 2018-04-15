using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BarrierHitListener : MonoBehaviour {
    private Vector3 objectSpacePos;
    private Material mat;

    private void Start()
    {
        mat = gameObject.GetComponent<MeshRenderer>().material;
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("OnTriggerEnter " + other.name);
        objectSpacePos = gameObject.transform.worldToLocalMatrix * new Vector4(0.0f, 1.0f, 0.0f, 1.0f);
        Debug.LogFormat("{0}, {1}, {2}", objectSpacePos.x, objectSpacePos.y, objectSpacePos.z);
        mat.SetVector("Vector3_C18AA2D4", new Vector4(objectSpacePos.x, objectSpacePos.y, objectSpacePos.z, 0.0f));
    }

    private void OnTriggerStay(Collider other)
    {
        // Debug.Log("OnTriggerStay " + other.name);
    }

    private void OnTriggerExit(Collider other)
    {
        Debug.Log("OnTriggerExit " + other.name);
    }

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("OnCollisionEnter");
    }
}
