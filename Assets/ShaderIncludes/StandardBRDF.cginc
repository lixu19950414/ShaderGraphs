float FresnelReflectanceSafe(float RF0, float NoH)
{
	float t = 1.0 - saturate(NoH);
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float r = lerp(RF0, 1.0, t5);
	return r;
}

float FresnelReflectance(float RF0, float NoH)
{
	float t = 1.0 - NoH;
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float r = lerp(RF0, 1.0, t5);
	return r;
}

float FresnelReflectanceSafe(float3 RF0, float NoH)
{
	float t = 1.0 - saturate(NoH);
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float3 r = lerp(RF0, float3(1.0, 1.0, 1.0), t5);
	return r;
}

float FresnelReflectanceSafe(float3 RF0, float NoH)
{
	float t = 1.0 - NoH;
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float3 r = lerp(RF0, float3(1.0, 1.0, 1.0), t5);
	return r;
}

float IORToRF0(float n)
{
	float t = (n - 1.0) / (n + 1.0);
	float RF0 = t * t;
	return RF0;
}

float RF0ToIOR(float RF0)
{
	float t = sqrt(RF0);
	float IOR = (1.0 + t) / (1.0 - t);
	return IOR;
}

float SinOfTotalInternalReflection(float RF0)
{
	float t = sqrt(RF0);
	float sine = (1.0 - t) / (1.0 + t);
	return sine;
}


