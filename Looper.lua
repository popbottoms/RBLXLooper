--!strict

-- @popbottoms

export type Looper = {
	Break: (Loop) -> (),
	new: ((Loop) -> ()) -> (Loop),
	Disconnect: (Loop) -> (),

	ActiveLoops: {Loop},
	__index: Looper
}

export type Loop = typeof(setmetatable({} :: {
	Looping: boolean,
	Thread: thread
}, {} :: Looper))

local Looper = {
	ActiveLoops = {}
} :: Looper

Looper.__index = Looper

function Looper:Break()
	self.Looping = false
	table.remove(Looper.ActiveLoops, table.find(Looper.ActiveLoops, self))
	coroutine.close(self.Thread)
end

Looper.Disconnect = Looper.Break

function Looper.new(Func: (Loop) -> ()): Loop
	local self = {Looping = true}
	setmetatable(self, Looper)
	
	self.Thread = coroutine.create(function()
		while self.Looping do
			Func(self)
		end
	end)
	
	coroutine.resume(self.Thread)
	table.insert(Looper.ActiveLoops, self)
	
	return self :: Loop
end

return Looper
