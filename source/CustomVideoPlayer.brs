
'************************************************************
'** Application startup
'************************************************************

'http://www.brightsign.biz/documents/BrightSignObjectReferenceManualv2.pdf

Sub main()     
    app = initApp()    
           
    print "loading.."
          
       paintScreen(app) 
       prepareClip(app)
                                       
       while true
        event = wait(0, app.port)
        if (event<> invalid)
            if (event.isRemoteKeyPressed())
                index = event.GetIndex()
                print index
                if (index = 4) OR (index = 2) 'Left or Up
                    
                else if (index = 5) OR (index = 3) 'Right or Down
                                        
                else if (index = 6) 'OK
                   ExitWhile  
                endif
                           
            endif
        endif
    end while
           
    print "bye."
End Sub

Function initApp()
   app = {}
   app.showOverlayMenu = false
   app.player = CreateObject("roVideoPlayer")  
   app.canvas = createObject("roImageCanvas")
   
    if type(app.player)<>"roVideoPlayer" then
        print "Unable to create videoplayer."
        stop   ' stop exits to the debugger
    endif    
   
    app.port = CreateObject("roMessagePort")
    app.player.SetMessagePort(app.port)
    app.canvas.SetMessagePort(app.port)    
    app.tvGuideData = loadTVGuideData()            
    return app
End Function

Function loadTVGuideData()
    jsonAsString = ReadAsciiFile("pkg:/json/tvGuide.json")
    tvGuideData = ParseJSON(jsonAsString)
    return tvGuideData     
End Function

Sub paintScreen(app)

    sysTime = CreateObject("roSystemTime")
    print "sysTime= " +  type(sysTime)    
    
    'if type(sysTime)<>"Invalid" then
     '  dt = sysTime.GetLocalDateTime()
      ' print dt.AsDateString("short-month")
      ' print " current time is " +  str(dt.GetHours()) + ":" + str(dt.GetMinutes())
    'endif
    print "paint"
    
    items = []
                      
     items.Push({
        url: "pkg:/images/light-5-transparent-gradient.png"
        TargetRect: {x: 550, y: 100, w: 494, h: 300}
        CompositionMode: "Source_Over" 
     })  
     
     items.Push({ 
        Text: "light-5-transparent-gradient.png"
        TextAttrs: { font: "large", color: "#a0a0a0" }       
         Color: "#a0000000" 
         CompositionMode: "Source_Over"
         TargetRect: {x: 550, y: 100, w: 494, h: 300}         
     }) 
     '-------------------------------------------------  
     items.Push({
        url: "pkg:/images/dark-transparent-horiz.png"
        TargetRect: {x: 150, y: 160, w: 494, h: 300}
        CompositionMode: "Source_Over" 
     })    
      
     items.Push({ 
        Text: "dark-transparent-horiz.png"
        TextAttrs: { font: "large", color: "#a0a0a0" }       
         Color: "#a0000000"
         CompositionMode: "Source_Over"
         TargetRect: {x: 150, y: 160, w: 494, h: 300}          
     })                 
   '-------------------------------------------------   
   'app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source_Over" })
    app.canvas.SetLayer(1, items)
    app.canvas.Show()
End Sub

Sub prepareClip(app)    

    app.player.SetLoop(false)
    app.player.SetPositionNotificationPeriod(5)
    sizeRect = app.canvas.GetCanvasRect()
    print "x=" + str(sizeRect.x) + ",y=" + str(sizeRect.y) + ",w=" + str(sizeRect.w) + ",h="+ str(sizeRect.h)
    app.player.SetDestinationRect({x: sizeRect.x, y: sizeRect.y, w: sizeRect.w, h: sizeRect.h}) 'fullscreen
    
    contentList = []    
        contentList.Push({
            Stream: { url: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8" }
            StreamFormat: "hls"
        })       
    app.player.SetContentList(contentList)    
    app.player.play()
    print "playing!"
End Sub
