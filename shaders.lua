local shaders = {}

function shaders.hitFlashShader(r , g, b)
    local s = [[]]..r..[[, ]]..g..[[, ]]..b..[[,]]
    local shader = [[
        vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords){
            return vec4(]]..s..[[ Texel(texture, textureCoords).a) * color;
        }
        ]]
    
    local whiteoutShader = love.graphics.newShader(shader)
    return whiteoutShader
end

return shaders