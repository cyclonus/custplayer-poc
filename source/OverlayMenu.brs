

Function GetMenuConfig(app)
    config = {} 
    config.menuImageURL = "pkg:/images/light-5-transparent-gradient.png"     
    config.screenPartitions  = 3
    config.leftAdjustment    = 0       
    config.animationStep     = int(int(app.screenDimensions.w / 2))/10
    config.x = app.screenDimensions.w + 1   
    config.menuVisibleFinalPosX = int(app.screenDimensions.w / config.screenPartitions)
    config.stat = "hidden"         
    return config
End Function

Function doShowMenu(app)
    print "do showins"
    app.stat = "showing"
End Function

Function doStopShowMenu(app)
    print "stop showing"
    app.stat = ""
End Function

Function handlePaintMenu(app)     
   if(app.stat <> "hidden")
   
          app.canvas.AllowUpdates(false) 
          app.canvas.ClearLayer(1)
          x = app.menuConfig.x
          y = 0
          w = app.screenDimensions.w
          h = app.screenDimensions.h
          
          menuRect = {x: x, y: y, w: w, h: h} 
    
          items = []                      
          items.Push({
            url: app.menuConfig.menuImageURL
            TargetRect: menuRect
            CompositionMode: "Source_Over" 
          })  
             
             
         ' items.Push({ 
         '     Text: "light-5-transparent-gradient.png"
         '     TextAttrs: { font: "large", color: "#a0a0a0" }       
         '     Color: "#a0000000" 
         '     CompositionMode: "Source_Over"
         '    TargetRect: {x: int((1280/3)*2), y: 0, w: int(1280/3), h: 720}         
         ' })      
         'app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source_Over" })
       
           if(app.stat = "showing")                               
              app.menuConfig.x = int(app.menuConfig.x - app.menuConfig.animationStep)         
              if(app.menuConfig.x <= app.menuConfig.menuVisibleFinalPosX)
                app.stat = "visible"
              end if              
         end if
         app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
         app.canvas.SetLayer(1, items)
         app.canvas.AllowUpdates(true)
                     
  end if
   
End Function