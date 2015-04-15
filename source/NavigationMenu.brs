

Function GetMenuConfig(app)
    config = {} 
    config.menuImageURL = "pkg:/images/light-5-transparent-gradient.png"     
    config.screenPartitions  = 4        
    config.stat = "hidden"             
    config.focusRectImageURL = "pkg:/images/small-roundrect.png"        
    config.focusedIndex = 1
    return config
End Function

Function doShowMenu(app)
    app.menuConfig.stat = "visible"
    app.menuConfig.focusedIndex = 1 
    paintMenu(app)
End Function

Function doHideMenu(app)    
    app.menuConfig.stat = "hidden"       
    paintMenu(app)
End Function

Function doFocusMenuItem(app)
   '
   paintMenu(app)
End Function


Function DrawFocusRectIfSelected(rect, items)   
      items.Push({
            url: app.menuConfig.focusRectImageURL
            TargetRect: rect
            CompositionMode: "Source_Over" 
         })          
   return items
End Function

Function GetMenuItems(app, menuRect, items)

   data = app.tvGuideData       
   
   menuSectionH = int(app.screenDimensions.w / 8)  
   
   x = menuRect.x
   y = menuRect.y + 100
   w1 = int(menuRect.w / 4)   
   h = menuSectionH 
   w2 = int(menuRect.w - w1)                   
   ' should use a fixed number here to draw the whole screen instead of the data returned by the api
   focusedIndex = app.menuConfig.focusedIndex
   indx = 0         
   for each showID in data.shows   
                                                                                        
       'Draw channel section        
       tvShow = data.shows[showID]        
       channelSectionRect = {x: x, y: y, w: 100, h: 100}
       
       for each channelID in tvShow.airsAt                 
         channelIconUrl = data.channels[channelID].icon 
         items.Push({
            url: channelIconUrl
            TargetRect: channelSectionRect
            CompositionMode: "Source" 
         })  
                                                                                
       end for
                     
           'Draw tv show section              
           tvShowSectionRect = {x: x + 150, y: y - 50, w: 300, h: 200}                                          
           items.Push({ 
                  Text: tvShow.name
                  TextAttrs: { font: "Medium", color: "#a0a0a0" }       
                  Color: "#a0000000" 
                  CompositionMode: "Source_Over"
                  TargetRect: tvShowSectionRect   
                  HAlign:"HCenter" 
                  VAlign:"VCenter"
                  Direction:"LeftToRight"                  
            })        
         
           
        y = y + menuSectionH 
        indx = indx + 1                                                    
   end for      
                     
   return items 
End Function

Sub paintMenu(app)  

   print "stat: " +  app.menuConfig.stat      
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
               
          items = GetMenuItems(app, menuRect, items)     
                                                                                          
          app.canvas.AllowUpdates(false)          
          app.canvas.Clear()  
          app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
          app.canvas.SetLayer(1, items)                                                                                      
          app.canvas.AllowUpdates(true)
          app.canvas.Show()         
   else
          'print "clear all"
          app.canvas.AllowUpdates(false)
          app.canvas.Clear()  
          app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
          app.canvas.AllowUpdates(true)
          app.canvas.Show()
                              
   end if   
   
End Sub

