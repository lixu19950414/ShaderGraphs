// Fresnel terms
float FresnelReflectance(float RF0, float NoH)
{
	float t = 1.0 - NoH;
	float t2 = t * t;
	float t5 = t2 * t2 * t;
	float r = lerp(RF0, 1.0, t5);
	return r;
}

float FresnelReflectance(float3 RF0, float NoH)
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

// Visibility terms (Shadowling and Masking)
float BlinnPhongVisibility(float NoL, float NoV)
{
	float visibility = NoL * NoV;
	return visibility;
}

float WardVisibility(float NoL, float NoV)
{
	float visibility = 1.0 / (NoL * NoV);
	return visibility;
}

float NeumannVisibility(float NoL, float NoV)
{
	float visibility = 1.0 / max(NoL, NoV);
	return visibility;
}

float AshikhminShirleyVisibility(float NoL, float NoV, float LoH)
{
	float visibility = 1.0 / (LoH * max(NoL, NoV));
	return visibility;
}

float AshikhminPremozeVisibility(float NoL, float NoV)
{
	float visibility = 1.0 / (NoL + NoV - NoL * NoV);
	return visibility;
}


// BRDFs

half3 NormalizedBlinnPhongBRDF(half3 diffColor, half3 specColor, float NoH, float NDF)
{
	half3 specular = (NDF + 8.0) / 8.0 * specColor * pow(NoH, NDF);
	return 0.31830988618 * (diffColor + specular);
}

half3 BlinnPhongBRDF(half3 diffColor, half3 specColor, float NoH, float NDF)
{
	half3 specular = specColor * pow(NoH, NDF);
	return diffColor + specular;
}

