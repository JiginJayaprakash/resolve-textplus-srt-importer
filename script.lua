local resolve = resolve or _G.resolve
local project = resolve:GetProjectManager():GetCurrentProject()
local timeline = project:GetCurrentTimeline()

if not timeline then
    print("Error: No active timeline found.")
    return
end

-- SEED RANDOM ONCE
math.randomseed(os.time())

-- CONFIGURATION
local srtPath =  "C:/Users/{user}/srt/file.srt"  --- add your srt file here
local frameRate = tonumber(project:GetSetting("timelineFrameRate"))

-- 1. TRACK MANAGEMENT
local vTrackCount = timeline:GetTrackCount("video")
for i = 1, vTrackCount do
    timeline:SetTrackEnable("video", i, false)
end

timeline:AddTrack("video")
local targetTrackIndex = vTrackCount + 1
timeline:SetTrackEnable("video", targetTrackIndex, true)

-- Helper: Convert SRT Time to Frames
function srtToFrames(timeStr, fps)
    local h, m, s, ms = timeStr:match("(%d%d):(%d%d):(%d%d),(%d%d%d)")
    if not h then return nil end
    local totalSeconds = (tonumber(h) * 3600) + (tonumber(m) * 60) + tonumber(s) + (tonumber(ms) / 1000)
    return math.floor(totalSeconds * fps)
end

-- Read SRT content
local file = io.open(srtPath, "r")
if not file then print("Error: File not found") return end
local content = file:read("*all")
file:close()
content = content:gsub("\r\n", "\n") .. "\n\n"

print("Importing SRT with 4:1 Font Ratio...")

-- 2. INSERTION LOOP
for block in content:gmatch("(%d%d:%d%d:%d%d,%d%d%d %-%-> %d%d:%d%d:%d%d,%d%d%d.-)\n\n") do
    local startTC, endTC = block:match("(%d%d:%d%d:%d%d,%d%d%d) %-%-> (%d%d:%d%d:%d%d,%d%d%d)")
    local text = block:match("%d%d:%d%d:%d%d,%d%d%d %-%-> %d%d:%d%d:%d%d,%d%d%d\n(.+)")

    if startTC and endTC and text then
        local startFrame = srtToFrames(startTC, frameRate)
        local endFrame = srtToFrames(endTC, frameRate)
        
        -- Fix: Ensure the playhead is moved and Mark In/Out is set clearly
        timeline:SetCurrentTimecode(tostring(startFrame))
        timeline:SetMarkInOut(startFrame, endFrame)
        
        local newClip = timeline:InsertFusionTitleIntoTimeline("Text+")

        if newClip then
            local comp = newClip:GetFusionCompByIndex(1)
            if comp then
                local tools = comp:GetToolList()
                for _, tool in ipairs(tools) do
                    if tool:GetInput("StyledText") then
                        local cleanText = text:gsub("\n", " ")
                        tool:SetInput("StyledText", cleanText)
                        
                        -- RANDOM FONT LOGIC (4:1 Ratio)
                        -- 80% Impact, 20% Playfair Display
                        local fontRoll = math.random(1, 5)
                        if fontRoll <= 4 then
							
							tool:SetInput("Font", "Ink Free")
							tool:SetInput("Style", "Regular")
                        else
                            tool:SetInput("Font", "Mistral")
							tool:SetInput("Style", "Regular")
                            
                        end

                        -- Styling: Element 2 (Background)
						tool:SetInput("Size", 0.15)
                        tool:SetInput("SelectElement", 2)
                        tool:SetInput("Enabled2", 1) 
                        tool:SetInput("Opacity2", 0.7) 
                        tool:SetInput("VerticalJustificationNew", 3)
                        break
                    end
                end
            end
        end
    end	
end

-- 3. CLEANUP
timeline:ClearMarkInOut()
for i = 1, vTrackCount do
    timeline:SetTrackEnable("video", i, true)
end

print("Done! Check Track " .. targetTrackIndex)
