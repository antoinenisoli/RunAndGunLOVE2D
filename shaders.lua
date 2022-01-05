shaders = {}

function shaders.hitFlashShader()
    local whiteoutShader = love.graphics.newShader[[
    vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords){
        return vec4(1, 1, 1, Texel(texture, textureCoords).a) * color;
    }
    ]]

    return whiteoutShader
end