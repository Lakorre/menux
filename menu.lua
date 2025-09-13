local MenuSize = vec2(600, 350)
local MenuStartCoords = vec2(500, 500) 
local TabsBarWidth = 0
local SectionsCount = 3 
local SectionsPadding = 10 
local MachoPaneGap = 10 

local SectionChildWidth = MenuSize.x - TabsBarWidth 
local EachSectionWidth = (SectionChildWidth - (SectionsPadding * (SectionsCount + 1))) / SectionsCount

-- Sections positions
local SectionOneStart = vec2(TabsBarWidth + (SectionsPadding * 1) + (EachSectionWidth * 0), SectionsPadding + MachoPaneGap)
local SectionOneEnd = vec2(SectionOneStart.x + EachSectionWidth, MenuSize.y - SectionsPadding)

local SectionTwoStart = vec2(TabsBarWidth + (SectionsPadding * 2) + (EachSectionWidth * 1), SectionsPadding + MachoPaneGap)
local SectionTwoEnd = vec2(SectionTwoStart.x + EachSectionWidth, MenuSize.y - SectionsPadding)

local SectionThreeStart = vec2(TabsBarWidth + (SectionsPadding * 3) + (EachSectionWidth * 2), SectionsPadding + MachoPaneGap)
local SectionThreeEnd = vec2(SectionThreeStart.x + EachSectionWidth, MenuSize.y - SectionsPadding)

local MenuWindow = nil

function OpenMachoMenu()
    if MenuWindow ~= nil then return end

    MenuWindow = MachoMenuWindow(MenuStartCoords.x, MenuStartCoords.y, MenuSize.x, MenuSize.y)
    MachoMenuSetAccent(MenuWindow, 137, 52, 235) -- لون بنفسجي

    -- === Section 1 ===
    local SectionOne = MachoMenuGroup(MenuWindow, "الأزرار", SectionOneStart.x, SectionOneStart.y, SectionOneEnd.x, SectionOneEnd.y)

    MachoMenuButton(SectionOne, "طباعة رسالة", function()
        print("[MACHO MENU] الزر الأول تم الضغط عليه!")
    end)

    MachoMenuButton(SectionOne, "إغلاق القائمة", function()
        MachoMenuDestroy(MenuWindow)
        MenuWindow = nil
    end)

    -- === Section 2 ===
    local SectionTwo = MachoMenuGroup(MenuWindow, "التحكم", SectionTwoStart.x, SectionTwoStart.y, SectionTwoEnd.x, SectionTwoEnd.y)

    MachoMenuSlider(SectionTwo, "السرعة", 50, 0, 100, "%", 0, function(value)
        print("تم ضبط السرعة إلى: " .. value)
    end)

    MachoMenuCheckbox(SectionTwo, "الوضع الليلي", function()
        print("تم التفعيل")
    end, function()
        print("تم الإلغاء")
    end)

    local textHandle = MachoMenuText(SectionTwo, "نص تجريبي")
    MachoMenuButton(SectionTwo, "تغيير النص", function()
        MachoMenuSetText(textHandle, "تم التغيير")
    end)

    -- === Section 3 ===
    local SectionThree = MachoMenuGroup(MenuWindow, "الإدخال", SectionThreeStart.x, SectionThreeStart.y, SectionThreeEnd.x, SectionThreeEnd.y)

    local inputHandle = MachoMenuInputbox(SectionThree, "أدخل اسمك", "اكتب هنا...")

    MachoMenuButton(SectionThree, "عرض الاسم", function()
        local input = MachoMenuGetInputbox(inputHandle)
        print("الاسم المدخل هو: " .. input)
    end)

    MachoMenuDropDown(SectionThree, "اختر خيارًا", function(index)
        print("الخيار المحدد: " .. index)
    end,
    "الخيار الأول",
    "الخيار الثاني",
    "الخيار الثالث")
end

-- مفتاح الفتح: F10 (رمزه = 121)
RegisterCommand("openmenu", function()
    OpenMachoMenu()
end)

RegisterKeyMapping("openmenu", "فتح قائمة Macho", "keyboard", "F10")
