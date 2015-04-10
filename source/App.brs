
'  This library is intended to provide a set of fucntions to help particion the scree and  
'
Function LoadTVGuideData()
    jsonAsString = ReadAsciiFile("pkg:/json/tvGuide.json")
    tvGuideData = ParseJSON(jsonAsString)
    return tvGuideData     
End Function

Function GetScreenDimensions(app)
   ' inches 
   screenDimensions = app.canvas.GetCanvasRect()
   print "x=" + str(screenDimensions.x) + ",y=" + str(screenDimensions.y) + ",w=" + str(screenDimensions.w) + ",h="+ str(screenDimensions.h)
   return screenDimensions
End Function

Function initApp()
   app = {}
   
   app.player = CreateObject("roVideoPlayer")  
   app.canvas = createObject("roImageCanvas")
   
    if type(app.player)<>"roVideoPlayer" then
        print "Unable to create videoplayer."
        stop   ' stop exits to the debugger
    endif    
   
    app.port = CreateObject("roMessagePort")
    app.player.SetMessagePort(app.port)
    app.canvas.SetMessagePort(app.port)    
    app.tvGuideData = LoadTVGuideData()  
    app.screenDimensions = GetScreenDimensions(app)
    app.menuConfig = GetMenuConfig(app)          
    return app
End Function


