//
//  File.metal
//  nfc-tagApp
//
//  Created by 本田輝 on 2024/03/03.
//

#include <metal_stdlib>
using namespace metal;

half4 hue2Rgba(half h) {
    half hueDeg = h * 360.0;
    half x = (1 - abs(fmod(hueDeg / 60.0, 2) - 1));
    half4 rgba;
    if (hueDeg < 60) rgba = half4(1, x, 0, 1);
    else if (hueDeg < 120) rgba = half4(x, 1, 0, 1);
    else if (hueDeg < 180) rgba = half4(0, 1, x, 1);
    else if (hueDeg < 240) rgba = half4(0, x, 1, 1);
    else if ( hueDeg < 300) rgba = half4(x, 0, 1, 1);
    else rgba = half4(1, 0, x, 1);
    return rgba;
}

// float2 position, half4 colorはcolorEffectに含まれるデフォルトの引数
// texture2d<half> voronoiは .image(voronoi)
// float offsetは .float(offset)
[[ stitchable ]] half4 holographic(float2 position, half4 color, texture2d<half> voronoi, float offset) {
    // positionがView上の位置なので、0〜1の値に正規化する(voronoiを3倍(Retina)サイズで作成しているのでx3してます）
    float2 coord = float2(position.x / voronoi.get_width() * 3, position.y / voronoi.get_height() * 3);
    // voronoiの値
    half4 sampled = voronoi.sample(metal::sampler(metal::filter::linear), coord);
    // offsetを足して少数部分を取り、色相からRGBに変換する
    half4 rgba = hue2Rgba(fract(sampled.x + offset));
    // 加算合成
    half4 mixed = mix(color, rgba, 0.04);
    mixed.a = color.a;
    return mixed;
}


