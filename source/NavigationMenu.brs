

Function GetMenuConfig(app)
    config = {} 
    config.menuImageURL = "pkg:/images/light-5-transparent-gradient.png"     
    config.screenPartitions  = 4        
    config.stat = "hidden"             
    config.focusRectImageURL = "pkg:/images/small-roundrect.png"        
    config.focusedIndex  = 1 
    config.focusedColumn = 1   ' here we can control if we have selected a channel or a TV-Show  
    return config
End Function

Function doShowMenu(app)
    app.menuConfig.stat = "visible"
    'app.menuConfig.focusedIndex = 1 
    paintMenu(app)
End Function

Function doHideMenu(app)    
    app.menuConfig.stat = "hidden"       
    paintMenu(app)
End Function

Function doFocusMenuItem(app)
   focusedIndex  = app.menuConfig.focusedIndex
   focusedColumn = app.menuConfig.focusedColumn 
   'print "focusedIndex= " + str(focusedIndex) + " focusedColumn= " + str(focusedColumn)  
   
   playClip(app)
   
End Function

Function DrawFocusRect(app, rect, items)   
      items.Push({
            url: app.menuConfig.focusRectImageURL
            TargetRect: rect
            CompositionMode: "Source_Over" 
         })          
   return items
End Function

Function GetSelectedTVShow(app)
    if(app.menuConfig.stat = "visible" and app.menuConfig.focusedColumn = 2)
        data = app.tvGuideData
        count = 1
        for each showID in data.shows
          if(count = app.menuConfig.focusedIndex)
             tvShow = data.shows[showID]
             return tvShow    
          end if        
          count = count + 1          
        end for
    end if    
    return invalid
end Function

Function GetMenuItems(app, menuRect, items)

   data = app.tvGuideData       
   
   menuSectionH = int(app.screenDimensions.w / 8)  
   
   x = menuRect.x
   y = menuRect.y + 100
   w1 = int(menuRect.w / 4)   
   h = menuSectionH 
   w2 = int(menuRect.w - w1)                   
   ' should use a fixed number here to draw the whole screen instead of the data returned by the api
   focusedIndex  = app.menuConfig.focusedIndex
   focusedColumn = app.menuConfig.focusedColumn
   
   count = 1         
   for each showID in data.shows   
                                                                                        
       'Draw channel section        
       tvShow = data.shows[showID]        
       channelSectionRect = {x: x, y: y, w: 100, h: 100}
      
     ' This make this code real slow to paint  try using SetRequireAllImagesToDraw
       for each channelID in tvShow.airsAt                 
         channelIconUrl = data.channels[channelID].icon 
         items.Push({
            url: channelIconUrl
            TargetRect: channelSectionRect
            CompositionMode: "Source_Over" 
         })                                                                                  
       end for
                                        
           'Draw tv show section              
           tvShowSectionRect = {x: x + 150, y: y - 50, w: 300, h: 200}                                          
           items.Push({ 
                  Text: tvShow.name
                  TextAttrs: { font: "Medium", color: "#a0a0a0" }       
                  Color: "#a0000000" 
                  CompositionMode: "Source"
                  TargetRect: tvShowSectionRect   
                  HAlign:"HCenter" 
                  VAlign:"VCenter"
                  Direction:"LeftToRight"                  
            })        
        
       ' do we need a flag to control selection ???
         
         ' if this condition is met, then we have selected a channel 
         if(count = focusedIndex and focusedColumn = 1) 
          items = DrawFocusRect(app, channelSectionRect, items)
         end if   
        
         'if this condition is met, then we have selected a show
         if(count = focusedIndex and focusedColumn = 2) 
          items = DrawFocusRect(app, tvShowSectionRect, items)
         end if           
           
        y = y + menuSectionH 
        count = count + 1                                                    
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
          'app.canvas.SetLayer(0, { Color: "#00000000", CompositionMode: "Source" })
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

