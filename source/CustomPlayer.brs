' For now a hard coded video

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