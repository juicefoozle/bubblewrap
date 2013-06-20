display.setStatusBar( display.HiddenStatusBar )
system.activate( "multitouch" )

 
----------------------------------------------------
--FORWARD DECLARATIONS
-- 

local sheetInfo_bubbles = require("sprites.bubbles_sheet@2x") -- lua file that Texture packer published
local ImageSheet_bubbles = graphics.newImageSheet( "sprites/bubbles_sheet@2x.png", sheetInfo_bubbles:getSheet() ) --texture file made with Texture packer
local sequenceData_bubbles= require("sprites.bubbles_sequences") -- animation sequences


local myBubbles = display.newGroup()
local bColumns = 10     -- number of bubbles per row
local bRows = 17        -- number of rows
local bCount = 0        -- DO NOT CHANGE this one as it'll mess up your group's index numbers if anything else than 0
local bubblesPopped = 0 -- self explaining, isnt it?
local bubblesWorth = 10 -- how many points is a bubble worth
local score = 0         -- the start score
local resetBubble       -- forward declaring of the reset Bubble function, 
                        -- that way you can call it from anywhere within this lua file, 
                        -- without the need of an unnecessary global function
local resetDelay = 1500 -- time in ms till the bubble resets to being unpopped


----------------------------------------------------
--FUNCTIONS
-- 

--TAP listener of the bubbles
local function bubbleTap( e )
    
    local t = e.target --t is the bubble
    
    --asking t if it's a popped bubble or not, if it is already popped: keep calm and carry on 
    if(not t.isPopped)then
        --change the Sprite (Image) to show the popped graphic, if you have an animation you need to add t:play()
        --but in this simple example its just one frame, so you dont have to add play() 
        t:setSequence( "popped" )
        --add one popped bubble to the bubblesPopped counter...
        bubblesPopped = bubblesPopped +1
        --...and multiply it with your bubblesWorth to get the score
        score = bubblesPopped * bubblesWorth
        --let the bubble know it has popped
        t.isPopped = true
        --replace print with you display text of the score
        print("current score: "..score)
        --initiate the timed bubble reset
        resetBubble(t.id)
    end

end

resetBubble = function (id)
    local function reset( e )
        --reset the Sprite (Image) to show the unpopped graphic
        myBubbles[id]:setSequence( "unpopped" )
        --tell the bubble it is available for some new popping action, yay.
        myBubbles[id].isPopped = false
    end
    --do the function above after the amount of miliseconds you defined at line 24: local resetDelay = 1500
    timer.performWithDelay(resetDelay, reset)
end

--initialise the game itself
local function initGame()
    for a=1, bRows do
        for b=1, bColumns do
            --bCount is our index to find the Bubble in the myBubbles Group
            bCount = bCount + 1
            --create a local bubble
            local myBubble = display.newSprite( ImageSheet_bubbles, sequenceData_bubbles)
            myBubble:setSequence( "unpopped" )
            --position the bubble on the screen, this way each bubble will be exactly aligned to one another
            myBubble:setReferencePoint(display.TopLeftReferencePoint);
            myBubble.x = myBubble.width * (b-1)
            myBubble.y = myBubble.height * (a-1)
            myBubble.id = bCount
            --tell the bubble that it isnt popped yet, we will ask the bubble later on tap
            --to decide how it shall react on a tap
            myBubble.isPopped = false
            --add the tap listener
            myBubble:addEventListener("tap", bubbleTap)
            
            --put the bubble in the group
            myBubbles:insert(myBubble)
        end
    end
    --scene.view:insert(myBubbles)
end

--reset game not implemented in the current game, as this is just a base structure. 
-- when you add a timer and an end of the game call this to start a new round
local function resetGame()
    --remove all bubbles
    for a=myBubbles.numChildren, 1, -1 do
        myBubbles[a]:removeSelf()
        myBubbles[a]= nil
    end
    --reset score and bcount and initialise a new fun round of the game
    score = 0
    bubblesPopped = 0
    bCount = 0
    initGame()
end

----------------------------------------------------
--INIT
-- 

local function init()
    initGame()
    --and whatever else you got to initialize, like HUD, UI, and so on
end

init() --if you're using scenes put this line into your scene:createScene function 
