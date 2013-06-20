local sheetInfo = require("sprites.bubbles_sheet@2x")
local aniT  = 1000 / 25 -- 25FPS
local aniT2 = 1000 / 15 -- 15FPS
local aniT3 = 1000 / 20 -- 20FPS


sequenceData_bubbles = 
{
    { name = "unpopped",  
      start = sheetInfo:getFrameIndex("bubble_a"),  
      count = 1, 
      time = 1 * aniT2,  
      loopCount = 1,   
    }, 

    { name = "popped",  
      start = sheetInfo:getFrameIndex("bubble_b"), 
      count = 1, 
      time = 1 * aniT2,  
      loopCount = 1,    
    },

    

}
return sequenceData_bubbles