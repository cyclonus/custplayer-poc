' For now a hard coded video

Sub defaultClip(app)    
    'app.player.SetLoop(false)
    'app.player.SetPositionNotificationPeriod(5)
    sizeRect = GetScreenDimensions(app)    
    app.player.SetDestinationRect(sizeRect) 'fullscreen
    
    contentList = []    
        contentList.Push({
            Stream: { url: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8" }
            StreamFormat: "hls"
        })       
    app.player.SetContentList(contentList)    
    app.player.play()
    print "playing!"
End Sub

Sub playClip(app)           
    tvShow = GetSelectedTVShow(app) 
    if(tvShow <> invalid)
      app.player.Stop()     
      sizeRect = GetScreenDimensions(app)    
      app.player.SetDestinationRect(sizeRect) 'fullscreen
      
      tvShowURL = tvShow.url    
      contentList = []    
         contentList.Push({
             Stream: { url: tvShowURL }
             StreamFormat: "hls"
         })       
      app.player.SetContentList(contentList)    
      app.player.play()
      print "now playing " + tvShowURL
    end if   
end Sub
