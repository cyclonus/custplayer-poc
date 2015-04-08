
'************************************************************
'** Application startup
'************************************************************
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
    return app
End Function

Sub paintScreen(app)
    print "paint"
    app.canvas.SetLayer(0, { 
        Text: "Hello World!",
        TextAttrs: { font: "large", color: "#a0a0a0" },
        TargetRect: {x: 10, y: 10, w: 100, h: 50},
        Color: "#a0000000", 
        CompositionMode: "Source_Over",
        TargetRect: {x: 350, y: 500, w: 598, h: 37} 
       })
    app.canvas.Show()
End Sub

Sub prepareClip(app)    

    app.player.SetLoop(false)
    app.player.SetPositionNotificationPeriod(5)
    app.player.SetDestinationRect({x: 0, y: 0, w: 600, h: 300}) 'fullscreen
    
    contentList = []    
        contentList.Push({
            Stream: { url: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8" }
            StreamFormat: "hls"
        })       
    app.player.SetContentList(contentList)    
    app.player.play()
    print "playing!"
End Sub
