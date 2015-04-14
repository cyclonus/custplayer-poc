

Function GetMenuConfig(app)
    config = {} 
    config.menuImageURL = "pkg:/images/light-5-transparent-gradient.png"     
    config.screenPartitions  = 4        
    config.stat = "hidden"         
    
    config.selectorImageURL = "pkg:/images/small-roundrect.png"    
    config.selectedShowID = invalid
    return config
End Function

Function doShowMenu(app)
    app.menuConfig.stat = "visible"
    paintMenu(app)
End Function

Function doHideMenu(app)    
    app.menuConfig.stat = "hidden"
    paintMenu(app)
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
            
   for each showID in data.shows   
                        
       'print "single show type: " + type(showID) + " value "+showID   
       'print data.shows[showID]
       o = data.shows[showID]        
       channelSectionRect = {x: x, y: y, w: 100, h: 100}
       
       for each channelID in o.airsAt                 
         channelIconUrl = data.channels[channelID].icon 
         items.Push({
            url: channelIconUrl
            TargetRect: channelSectionRect
            CompositionMode: "Source_Over" 
         })                                                               
       end for
       
       tvShowSectionRect = {x: x + 150, y: y - 50, w: 200, h: 200}
       ' tv show section                                   
       items.Push({ 
              Text: o.name
              TextAttrs: { font: "Medium", color: "#a0a0a0" }       
              Color: "#a0000000" 
              CompositionMode: "Source_Over"
              TargetRect: tvShowSectionRect   
              HAlign:"HCenter" 
              VAlign:"VCenter"
              Direction:"LeftToRight"                  
        })        
           
        y = y + menuSectionH 
        
       if(app.menuConfig.selectedShowID = invalid)
          app.menuConfig.selectedShowID = showID
       end if 
                                             
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
               
          items = GetMenuItems(app, menuRect, items)     
                                                                                          
          app.canvas.AllowUpdates(false)          
          app.canvas.ClearLayer(1)  
          app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
          app.canvas.SetLayer(1, items)                                                                                      
          app.canvas.AllowUpdates(true)
          app.canvas.Show()         
   else
          'print "clear all"
          app.canvas.AllowUpdates(false)
          app.canvas.ClearLayer(1)  
          app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
          app.canvas.AllowUpdates(true)
          app.canvas.Show()
                              
   end if   
   
End Function


Function GetSelectedTitle()
  return -1
End Function