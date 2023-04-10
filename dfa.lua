local dfa = {}

function dfa.new()
    return {
        start = nil,
        currentState = nil,
        states = {},
        transitions = {},
        makeTransition = function (self)
            return function (origin, transitionLabel)
                print(dfa.tostring(self) .. " transition from " .. tostring(origin) .. " using \"" .. tostring(transitionLabel) .. "\"")
                local destinationLabel = self.transitions[origin.label][transitionLabel]
                local destination = self.states[destinationLabel]

                self.currentState = destination
                destination:enter()
            end
        end        
    }
end

function dfa.addState(self, label, update)

    if label then
        local state = {}

        state.label = label
        state.transition = self:makeTransition()
        state.update = (type(update) == "function") and update or function () end
        state.enter = function () print("entering state " .. tostring(label)) end

        self.states[label] = state
    end
end

function dfa.addTransition(self, labelOrigin, transition, labelDestination)
    local transitionsFromOrigin = self.transitions[labelOrigin]
    local transitions = transitionsFromOrigin or {}

    transitions[transition] = labelDestination

    if not transitionsFromOrigin then
        self.transitions[labelOrigin] = transitions
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

    start:enter()
end

function dfa.update(self)
    local state = self.currentState

    if state then
        state:update()
    end
end

function dfa.tostring(self) 
    local count = dfa.stateCount(self)
    local statesPluralized = count == 1 and "state" or "states"
    return "<dfa: " .. tostring(count) .. " " .. statesPluralized .. ">"
end

return dfa