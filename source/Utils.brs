
'  This library is intended to provide a set of fucntions to help particion the scree and  
'

Function GetScreenDimensions(app)
   ' inches 
   screenDimensions = app.canvas.GetCanvasRect()
   print "x=" + str(screenDimensions.x) + ",y=" + str(screenDimensions.y) + ",w=" + str(screenDimensions.w) + ",h="+ str(screenDimensions.h)
   return screenDimensions
End Function

Function getScreeAssetsConfig()
    assets = {} 
    assets.menuFragmentImage  = "light-4-transparent-gradient.png"
    assets.menuFragmentWidht  = 213
    assets.menuFragmentHeight = 120  
    assets.screenPartitions   = 3
    assets.leftAdjustment     = 5          
 return assets
End Function

Function computeScreenAreas(app)   
   'here we set the image that will be used to fill the right-hand side area  of the screen to draw the selection menu 
   if(type(app.screeConfig) = "Invalid")
     app.assetsConfig = getScreeAssetsConfig()
   Endif
   screenDimensions = GetScreenDimensions(app)
   n = screenDimensions.h / app.assetsConfig.menuFragmentHeight
   x = (screenDimensions.w / app.assetsConfig.screenPartitions) - app.assetsConfig.leftAdjustment
   y = 0
   
   screenData = {}
    
   screenData.n = n
   screenData.x = x
   screenData.y = y 
   return screenData
End Function

Function loadTVGuideData()
    jsonAsString = ReadAsciiFile("pkg:/json/tvGuide.json")
    tvGuideData = ParseJSON(jsonAsString)
    return tvGuideData     
End Function