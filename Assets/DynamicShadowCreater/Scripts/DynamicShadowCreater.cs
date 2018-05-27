using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DynamicShadowCreater : MonoBehaviour {
    // Settings
    public Light mainLight;
    public float near = 0.1f;
    public float far = 10.0f;
    public float size = 5.0f;
    public int depthTextureSize = 2048;
    public string[] layers;
    public float bias = 0.01f;
    public bool debug = true;

    private Camera mainCamera;
    private RenderTexture renderDepthTexture;

    private void Awake()
    {
        // Initialize depth texture
        renderDepthTexture = RenderTexture.GetTemporary(depthTextureSize, depthTextureSize, 16, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
        renderDepthTexture.filterMode = FilterMode.Point;
        // Initialize camera
        mainCamera = gameObject.AddComponent<Camera>();
        mainCamera.enabled = false;
        mainCamera.targetTexture = renderDepthTexture;
        mainCamera.cameraType = CameraType.Game;
        mainCamera.clearFlags = CameraClearFlags.Color;
        mainCamera.backgroundColor = Color.white;
        mainCamera.allowDynamicResolution = false;
        mainCamera.allowHDR = false;
        mainCamera.allowMSAA = false;
        mainCamera.orthographic = true;
        mainCamera.orthographicSize = size;
        mainCamera.farClipPlane = far;
        mainCamera.nearClipPlane = near;
        mainCamera.renderingPath = RenderingPath.Forward;
        mainCamera.SetReplacementShader(Shader.Find("Hidden/HiddenDYShadow"), "");
        Transform lightTransform = mainLight.GetComponent<Transform>();
        Transform selfTransform = gameObject.GetComponent<Transform>();
        selfTransform.position = lightTransform.position;
        selfTransform.rotation = lightTransform.rotation;
        mainCamera.cullingMask = LayerMask.GetMask(layers);

        Shader.SetGlobalMatrix("_DYShadowProj", mainCamera.projectionMatrix);
        Shader.SetGlobalMatrix("_DYShadowWorldToCamera", mainCamera.worldToCameraMatrix);
        Shader.SetGlobalTexture("_DYShadowTex", renderDepthTexture);
        Shader.SetGlobalFloat("_DYShadowOneDivideFar", 1.0f / far);
        Shader.SetGlobalFloat("_DYShadowBias", bias);
    }


    private void Start ()
    {

    }

    private void OnGUI()
    {
        if (debug)
        {
            GUI.DrawTexture(new Rect(0, 0, 200, 200), renderDepthTexture, ScaleMode.ScaleToFit, false);
        }
    }

    private void LateUpdate ()
    {
        mainCamera.Render();
        Shader.SetGlobalTexture("_DYShadowTex", renderDepthTexture);
    }

    private void OnDestroy()
    {
        RenderTexture.ReleaseTemporary(renderDepthTexture);
    }
}
