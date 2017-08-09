﻿Shader "Unlit/PortalBorderShader"
{
  Properties
  {
  }
  SubShader
  {
    Tags { "RenderType"="Opaque" }
    LOD 100

    Pass
    {
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag

      #include "UnityCG.cginc"

      float rand(float3 co)
      {
        return frac(sin( dot(co.xyz ,float3(12.9898,78.233,45.5432) )) * 43758.5453);
      }

      struct appdata
      {
        float4 vertex : POSITION;
      };

      struct v2f
      {
        float2 screen : TEXCOORD0;
        float vw : TEXCOORD1;
        float4 vertex : SV_POSITION;
      };

      v2f vert (appdata v)
      {
        v2f o;
        o.vertex = UnityObjectToClipPos(v.vertex);
        o.vertex.x += (rand(o.vertex.xyz)-0.5)*0.4;
        o.vertex.y += (rand(o.vertex.xyz)-0.5)*0.4;
        o.vertex.z += (rand(o.vertex.xyz)-0.5)*0.4;
        o.screen = ComputeScreenPos(o.vertex);
        o.vw = o.vertex.w;
        return o;
      }

      fixed4 frag (v2f i) : SV_Target
      {
        float y = i.screen.y/i.vw;
        float a = 0.6+sin(y*10000)*0.2;
        fixed4 col = fixed4(0.8,0.8,1.0,a);

        return col;
      }
      ENDCG
    }
  }
}
