#version 330 core
in vec3 fragmentColor;
in vec3 positionWorldspace;
in vec3 normalViewspace;
in vec3 eyeDirectionViewspace;
in vec3 lightDirectionViewspace;

out vec4 color;

void main(){
    vec3 LightColor = vec3(1.0, 1.0, 1.0); 

    vec3 AmbientColor = vec3(0.1, 0.1, 0.1) * fragmentColor;

    vec3 n = normalize(normalViewspace);
    vec3 l = normalize(lightDirectionViewspace);
    float cosTheta = clamp( dot( n, l ), 0, 1 );
    vec3 DiffuseColor = fragmentColor * LightColor * cosTheta;
	
    vec3 v = normalize(eyeDirectionViewspace);
    vec3 R = reflect(-l, n);
    float cosAlpha = clamp( dot( v, R ), 0, 1 );
    vec3 SpecularColor = vec3(0.3, 0.3, 0.3) * fragmentColor * LightColor * pow(cosAlpha,5);

    color = vec4(AmbientColor + DiffuseColor + SpecularColor, 1.0);
}
