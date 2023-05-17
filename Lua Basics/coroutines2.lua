simple_coroutine = coroutine.create(function()
    print("step1")
    coroutine.yield("ciao", "ciao2")
    print("step2")
    coroutine.yield()
    print("step3")
    coroutine.yield()

    print("step4")
    coroutine.yield()
    print("step5")
    coroutine.yield()
    print("step6")
end)

simple_coroutine2 = coroutine.create(function()
    print("step1")
    coroutine.yield()
    print("step2")
    coroutine.yield()
    print("step3")
    coroutine.yield()

    print("step4")
    coroutine.yield()
    print("step5")
    coroutine.yield()
    print("step6")
end)

-- print("starting coroutine")

-- alive, ret = coroutine.resume(simple_coroutine)
-- print(alive, ret)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- print(alive, ret)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- print(alive, ret)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- alive, ret = coroutine.resume(simple_coroutine)
-- print(alive, ret)

-- alive = true
-- while alive do
--     alive = coroutine.resume(simple_coroutine)
--     coroutine.resume(simple_coroutine2)
-- end

print(coroutine.status(simple_coroutine))

active_coroutines = {}
sleeping_coroutines = {}

-- loop engine/scheduler (cooperative multitasking)
while true do
    for coro in pairs(active_coroutines) do
        alive, v0, v1 = coroutine.resume(coro)
        if v0 == "wait" then
            table.insert(sleeping_coroutines, 0, simple_coroutine)
        end
        print(alive, v0, v1)
    end
end

-- different examples of schedulers

function start()
    scheduler.attack = attack001
    scheduler.attack002 = attack002
end

function tick()
    if state == "animating" then
        coroutine.resume(scheduler.attack)
    end
end