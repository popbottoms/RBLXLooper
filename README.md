# RBLXLooper
Simple module made for managing loops in Roblox

I made this module while learning Type Checking a while back, and I thought to release it to the public, as I find it somewhat useful

## Usage
### Creating a Loop
```lua
local Looper = require(path.to.Looper)

local MyLoop = Looper.new(function(self)
    print("Looping")
    task.wait(1)
end)
```

### Breaking/Disconnecting a Loop
```lua
local Count = 0
local MyLoop = Looper.new(function(self)
    print("Looping")
        
    Count = Count + 1
    if Count >= 5 then
	    self:Break() -- Break the loop (You can also use `break`, but this is recommended)
    end
    
    task.wait(1)
end)

-- Breaking the loop from outside
MyLoop:Break()
```
I'd like to add, that you can also use ``MyLoop:Disconnect()`` which does the same thing as ``MyLoop:Break()``

## Properties

### Looper
- Looper.ActiveLoops -- A table of all of the active loops, incase you want to break them all

### Loop
- MyLoop.Looping -- A bool that tells you if the loop is active or not
