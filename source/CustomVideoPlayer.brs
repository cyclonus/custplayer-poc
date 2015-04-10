
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



Sub paintScreen(app)
'http://www.rexdot.com/wordpress/wp-content/plugins/perspective/perspective/images/bg/
'http://forums.roku.com/viewtopic.php?p=466930&sid=cf7bdcb7ca7d0e4a83fd1d93e157aaba

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
        TargetRect: {x: int((1280/3)*2), y: 0, w: int(1280/3), h: 720}
        CompositionMode: "Source_Over" 
     })  
     
     items.Push({ 
         Text: "light-5-transparent-gradient.png"
         TextAttrs: { font: "large", color: "#a0a0a0" }       
         Color: "#a0000000" 
         CompositionMode: "Source_Over"
         TargetRect: {x: int((1280/3)*2), y: 0, w: int(1280/3), h: 720}         
     }) 
     
   'app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source_Over" })
    app.canvas.SetLayer(1, items)
    app.canvas.Show()
End Sub

Sub prepareClip(app)    

    app.player.SetLoop(false)
    app.player.SetPositionNotificationPeriod(5)
    sizeRect = GetScreenDimensions(app)
    
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
