Shader "CG/BlinnPhongGouraud"
{
    Properties
    {
        _DiffuseColor ("Diffuse Color", Color) = (0.14, 0.43, 0.84, 1)
        _SpecularColor ("Specular Color", Color) = (0.7, 0.7, 0.7, 1)
        _AmbientColor ("Ambient Color", Color) = (0.05, 0.13, 0.25, 1)
        _Shininess ("Shininess", Range(0.1, 50)) = 10
    }
    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ForwardBase" } 

            CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #include "Lighting.cginc"

                // Declare used properties
                uniform fixed4 _DiffuseColor;
                uniform fixed4 _SpecularColor;
                uniform fixed4 _AmbientColor;
                uniform float _Shininess;

                struct appdata
                { 
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                };

                struct v2f
                {
                    float4 pos : SV_POSITION;
                    float3 normal : NORMAL;
                };


                v2f vert (appdata input)
                {
                    v2f output;
                    output.pos = UnityObjectToClipPos(input.vertex);
                    output.normal = input.normal;
                    return output;
                }


                fixed4 frag (v2f input) : SV_Target
                {
                    fixed4 colorA = _AmbientColor * _LightColor0;
                    fixed4 colorD = max(dot(_WorldSpaceLightPos0, input.normal), 0) *
                        _DiffuseColor * _LightColor0;
                    fixed3 h = normalize(_WorldSpaceLightPos0 + _WorldSpaceCameraPos);
                    return fixed4(0, 0, 1.0, 1.0);
                }

            ENDCG
        }
    }
}
