float FresnelReflectanceSafe(float RF0, float NoL)
{
	float t = 1.0 - saturate(NoL);
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float r = lerp(RF0, 1.0, t5);
	return r;
}

float FresnelReflectanceSafe(float3 RF0, float NoL)
{
	float t = 1.0 - saturate(NoL);
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float3 r = lerp(RF0, float3(1.0, 1.0, 1.0), t5);
	return r;
}

float IORToRF0(float n)
{
	float t = (n - 1) / (n + 1);
	float RF0 = t * t;
	return RF0;
}

