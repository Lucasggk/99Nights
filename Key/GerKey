local function seededRandom(seed)
    local s = seed % 2147483647
    return function()
        s = (s * 16807) % 2147483647
        return (s - 1) / 2147483646
    end
end

local function randomHex(n, rand)
    local chars = "0123456789abcdef"
    local result = ""
    for i = 1, n do
        local index = math.floor(rand() * #chars) + 1
        result = result .. chars:sub(index, index)
    end
    return result
end

local function gerarKey()
    local date = os.date("!*t")
    local seed = date.day + (date.month - 1) + date.year
    local rand = seededRandom(seed)
    local part1 = randomHex(4, rand)
    local part2 = randomHex(4, rand)
    local part3 = randomHex(4, rand)
    local part4 = randomHex(4, rand)
    return string.format("LKZh-%s-%s-%s-%s", part1, part2, part3, part4)
end

return gerarKey()
