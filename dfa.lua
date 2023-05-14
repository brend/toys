dfa = {}

local noOp <const> = function () end

function dfa.new()
    return {
        start = nil,
        currentState = nil,
        states = {},
        makeTransition = function (self)
            return function (origin, destinationLabel)
                local destination = self.states[destinationLabel]

                if not destination then
                    print("unknown destination label: " .. tostring(destinationLabel))
                    return
                end

                self.currentState = destination
                destination:enter(self.userInfo)
            end
        end,
        makeLoadScene = function (self)
            return function (state, sceneName)
                self.finished = true
                self.nextScene = sceneName
            end
        end,
        makeFinished = function (self) 
            return function (state)
                self.finished = true
                self.nextScene = nil
            end
        end,
        userInfo = {}
    }
end

function dfa.addState(self, label, update, enter)
    if label then
        local state <const> = {}

        state.label = label
        state.transition = self:makeTransition()
        state.loadScene = self:makeLoadScene()
        state.finished = self:makeFinished()

        -- if "update" is a table, 
        -- arguments "update" and "enter" are expected 
        -- to be fields of that table
        if type(update) == "table" then
            local t <const> = update

            update = t.update
            enter = t.enter
        end

        state.update = (type(update) == "function") and update or noOp
        state.enter = (type(enter) == "function") and enter or noOp 

        self.states[label] = state
    end
end

function dfa.stateCount(self)
    local count = 0

    for _ in pairs(self) do
        count = count + 1
    end

    return count
end

function dfa.run(self)
    local start = self.states[self.start]

    if not start then return end

    self.currentState = start

    start:enter(self.userInfo)
end

function dfa.update(self)
    local state = self.currentState

    if state then
        state:update(self.userInfo)
    end
end

function dfa.tostring(self) 
    local count = dfa.stateCount(self)
    local statesPluralized = count == 1 and "state" or "states"
    return "<dfa: " .. tostring(count) .. " " .. statesPluralized .. ">"
end

return dfa