local function log(name, value)
    print(("========== %s =========="):format(name))

    if value == nil then
        print("nil")
        return
    end

    if type(value) == "table" then
        local count = 0

        for k, v in pairs(value) do
            count += 1

            if count <= 30 then
                print(("[%s] = %s"):format(tostring(k), tostring(v)))
            end
        end

        print("Количество элементов:", count)

        if count > 30 then
            print("... показаны первые 30")
        end
    else
        print(tostring(value))
    end
end


-- 1. getgc
if type(getgc) == "function" then
    local result = getgc()
    log("getgc()", result)
else
    print("[!] getgc() отсутствует")
end


-- 2. getreg
if type(getreg) == "function" then
    local result = getreg()
    log("getreg()", result)
else
    print("[!] getreg() отсутствует")
end


-- 3. getrenv
if type(getrenv) == "function" then
    local result = getrenv()
    log("getrenv()", result)
else
    print("[!] getrenv() отсутствует")
end


-- 4. getloadedmodules
if type(getloadedmodules) == "function" then
    local result = getloadedmodules()
    log("getloadedmodules()", result)
else
    print("[!] getloadedmodules() отсутствует")
end


-- 5. getrunningscripts
if type(getrunningscripts) == "function" then
    local result = getrunningscripts()
    log("getrunningscripts()", result)
else
    print("[!] getrunningscripts() отсутствует")
end


-- 6. getscriptbytecode
if type(getscriptbytecode) == "function" then
    print("========== getscriptbytecode() ==========")

    local modules = getloadedmodules()
    local processed = 0

    for _, script in ipairs(modules) do
        if script:IsA("ModuleScript") or script:IsA("LocalScript") then
            local success, result = pcall(function()
                return getscriptbytecode(script)
            end)

            if success then
                print("[BYTECODE]", script:GetFullName())
                print("Length:", #result)
                processed += 1
            else
                print("[ERROR]", script:GetFullName(), result)
            end

            if processed >= 20 then
                break
            end
        end
    end

    print("Обработано:", processed)
else
    print("[!] getscriptbytecode() отсутствует")
end

print("========== SCAN FINISHED ==========")
