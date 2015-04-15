
Function GetTVGuideData()
    jsonAsString = ReadAsciiFile("pkg:/json/tvGuide.json")
    tvGuideData = ParseJSON(jsonAsString)
    return tvGuideData     
End Function

Function GetScreenDimensions(app)
   ' inches 
   screenDimensions = app.canvas.GetCanvasRect()
   ' print "x=" + str(screenDimensions.x) + ",y=" + str(screenDimensions.y) + ",w=" + str(screenDimensions.w) + ",h="+ str(screenDimensions.h)
   return screenDimensions
End Function

Function initApp()
   app = {}
   
   app.player = CreateObject("roVideoPlayer")  
   app.canvas = createObject("roImageCanvas")
   
    if type(app.player)<>"roVideoPlayer" then
        print "Unable to create videoplayer."
        stop  ' stop exits to the debugger
    endif    
   
    app.port = CreateObject("roMessagePort")
    app.canvas.SetMessagePort(app.port)  
    app.player.SetMessagePort(app.port)            
    app.screenDimensions = GetScreenDimensions(app)
    app.menuConfig = GetMenuConfig(app)
    app.tvGuideData = GetTVGuideData()          
    return app
End Function


