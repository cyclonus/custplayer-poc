

Function GetMenuConfig(app)
    config = {} 
    config.menuImageURL = "pkg:/images/light-5-transparent-gradient.png"     
    config.screenPartitions  = 4        
    config.stat = "hidden"         
    
    config.selectorImageURL = "pkg:/images/small-roundrect.png"    
    
    return config
End Function

Function doShowMenu(app)
    print "do showins"
    app.menuConfig.stat = "visible"
    paintMenu(app)
End Function

Function doHideMenu(app)
    print "stop showing"
    app.menuConfig.stat = "hidden"
    paintMenu(app)
End Function

Function GetContentItems(app, menuRect, items)
   data = app.tvGuideData    
   print " number of shows " +  str(data.shows.Count())
   
   menuSectionSize = int(app.screenDimensions.w / 8)  
   
   x = menuRect.x
   y = menuRect.y
   w = int(menuRect.w / 2) 
   h = menuSectionSize 
                     
   For each show in data.shows ' should use fixed number here to draw the screen instead of data returned by the api
   
           channelSectionRect = {x: x, y: y, w: w, h: h}           
                                                      
           ' channel section                                   
           items.Push({ 
                  Text: show.name
                  TextAttrs: { font: "Medium", color: "#a0a0a0" }       
                  Color: "#a0000000" 
                  CompositionMode: "Source_Over"
                  TargetRect: channelSectionRect        
            })            
            
           tvShowSectionRect = {x: x + int(w/2), y: y, w: w, h: h}    
           ' tv show section                                   
           items.Push({ 
                  Text: show.name
                  TextAttrs: { font: "Medium", color: "#a0a0a0" }       
                  Color: "#a0000000" 
                  CompositionMode: "Source_Over"
                  TargetRect: tvShowSectionRect        
            })    
            
            y = y + menuSectionSize               
   end for
   return items 
End Function

Function paintMenu(app)  
   'print "stat: " +  app.menuConfig.stat   
   if(app.menuConfig.stat = "visible")
             
          x = int(app.screenDimensions.w / 2)
          y = 0
          w = app.screenDimensions.w 
          h = app.screenDimensions.h          
          menuRect = {x: x, y: y, w: w, h: h}     
          items = []                      
          items.Push({
            url: app.menuConfig.menuImageURL
            TargetRect: menuRect
            CompositionMode: "Source" 
          })  
               
          items = GetContentItems(app,menuRect,items)     
                                                                                          
          app.canvas.AllowUpdates(false)          
          app.canvas.ClearLayer(1)  
          app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
          app.canvas.SetLayer(1, items)                                      
                                                
          app.canvas.AllowUpdates(true)
          app.canvas.Show()         
   else
          print "clear all"
          app.canvas.AllowUpdates(false)
          app.canvas.ClearLayer(1)  
          app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
          app.canvas.AllowUpdates(true)
          app.canvas.Show()
                              
   end if   
   
End Function