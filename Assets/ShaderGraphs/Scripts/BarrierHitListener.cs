using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BarrierHitListener : MonoBehaviour {

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("OnTriggerEnter " + other.name);
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
