-- Lua lesson

--[[ Multiline
comment --]]

print("Hello")

print(var) -- will be nil (null) becouse it's not declared and doesn't contain a value

function setup()
    var = 1
    
    for n = 1, 6, 2 do
        print(n .. "counter!")
    end

end

setup()

print(var) -- will be 1 becouse we called the method and then printed the variable with value 1

print(type(var)) -- returns the type of the item passed in the brackets

-- Tables

table001 = {} -- initializing a table
table001["hello"] = "world" -- like a dictionary
table002 = table001
-- accessing the dict in 2 ways: table002["hello"] OR table002.hello (it's the same)
-- concatenating informations in the print method now with ".." instead of "+"
print("table: " .. table002["hello"] .. " " .. table002.hello .. " " .. table001.hello)

print(table001)
print(table002)

-- Functions
table002["callme"] = function(a, b)
    return a + b
end

-- Declaring the same function as before, with another way
function table002.callme2(a, b)
    return a + b
end

table003 = {}
table003.functions = table002
print("result " .. table002.callme(1, 2))
print(table003.functions.callme(1, 3))

-- Array
table003[5] = "ciao"
table003["S"] = "S"

-- "!=" now is "~="

function test()
    return 1, 2, 3, 4
end

a, b, c = test()
print(a, b, c)

-- Note: We can declare local variables with "local" keyword

function actors()
    local counter = 0
    local names = {"Giuseppe" , "Mario", "Luca"}

    function next_actor()
        counter = counter + 1
        return names[counter]
    end

    return next_actor
end

for actor in actors() do
    print(actor)
end

-- pairs

function aivpairs(items)
    local counter = 0

    function next_item()
        counter = counter + 1
        return items[counter]
    end

    return next_item
end

local names = {"Giuseppe" , "Mario", "Luca"}

for actor in aivpairs(names) do
    print(actor)
end

-- ipairs

function aivipairs(items)
    local counter = 0

    function next_item()
        counter = counter + 1
        if items[counter] then
            return counter, items[counter]
        else
            return nil
        end
    end

    return next_item
end

for i, actor in aivipairs(names) do
    print(i, actor)
end

function simple_say(a, b, ...)
    local arg = {...}
    print(a, b)
    print(arg[1], arg[2], arg[3])
end

function say(...)
    local arg = {...}
    for i, v in ipairs(arg) do
        print("arg", i, v)
    end
end

simple_say(1, 2, 3, 4, 5)
say(1, 2, 3, 4, 5, 6)

-- iterator

function iterate(items, callback, ...)
    for i, v in ipairs(items) do
        callback(v, {...})
    end
end

iterate({"uno", "due", "tre"}, function(item, value)
    print(item, value[1])
end, "ciao")

local f0 = load("i = 1; return i + 2")
a = f0()
print(a)

-- Calling aiv module

aiv01 = require("aiv")
print(aiv01)
print(aiv01.add(1, 2))

function throw()
    return 1, 2, 3
    -- error("THROW!")
end

status, ret0, ret1, ret2 = pcall(throw)
if status then
    print("ok", ret0, ret1, ret2)
else
    print("Error!")
end

-- metatables

aiv02 = {"Prog", "Graf", "GD"}
aiv02_meta = {}

function aiv02_meta.__tostring(t)
    return "First element: " .. t[1]
end

function aiv02_meta.kill(t)
    return "Hello"
end

setmetatable(aiv02, aiv02_meta)
print(aiv02)

function superprint(item)
    mt = getmetatable(item)
    if mt then
        print(mt.kill(item))
    else
        print(item)
    end
end

vector_mt = {}
vector_mt.__add = function(a, b)
    return {a[1] + b[1], a[2] + b[2], a[3] + b[3]}
end

vector_mt.__index = function(t, key)
    local mapping =
    {
        x = 1,
        y = 2,
        z = 3
    }
    i = mapping[key]
    if i then
        return t[i]
    else
        return nil -- or it could return any other value
    end
end

vector0 = {1, 2, 3}
vector1 = {4, 5, 6}

setmetatable(vector0, vector_mt)
setmetatable(vector1, vector_mt)

v = vector0 + vector1
setmetatable(v, vector_mt)
print(v[1], v[2], v[3])

superprint(aiv02)

print(v.x, v.y, v.z, v.w)

-- _G is the environment variable that records all the informations used in the code
for v in pairs(_G) do
    print(v)
end

Warrior = {}

-- ":" allows you to pass the variable before the ":" in the argument of the function
-- in a function, you get the "self" reference thanks to the use of ":"
function Warrior:new()
    print("Creating new object", self)
    t = {xp = 100, hp = 200}
    print("mapping", t, "to", self)
    setmetatable(t, self)
    self.__index = self
    return t
end

--[[
function Warrior.__index(t, key)
    print("requested", key)
    return Warrior[key]
end
--]]

function Warrior:add_xp()
    self.xp = self.xp + 10
end

--[[
another_warrior = Warrior

Warrior = nil

warrior002 = another_warrior

another_warrior:add_xp()
warrior002:add_xp()

print(another_warrior.xp)
print(warrior002.xp)
--]]

warrior003 = Warrior:new()
warrior004 = Warrior:new()

warrior003:add_xp()
warrior004:add_xp()
warrior004:add_xp()

print(warrior003.xp)
print(warrior004.xp)


Archer = Warrior:new()

function Archer:shot()
    self.hp = self.hp - 10
end

archer001 = Archer:new() -- valid, but archer is a warrior
archer001:shot()