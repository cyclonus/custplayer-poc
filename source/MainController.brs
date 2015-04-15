
'************************************************************
'** Application startup
'************************************************************

'http://www.brightsign.biz/documents/BrightSignObjectReferenceManualv2.pdf

Function onFocusItem(app)
   if(app.menuConfig.stat = "visible")
       doFocusMenuItem(app)
   end if
End function

Function onLeftKey(app)
    if(app.menuConfig.stat = "hidden") 
       doShowMenu(app)          
    endif
end Function

Function onRightKey(app)
    if(app.menuConfig.stat = "hidden") 
       doShowMenu(app)          
    endif
end Function

Function onUpKey(app)
   if(app.menuConfig.stat = "visible")
     
     return 1
   endif
   return -1 
End Function

Function onDownKey(app)
   return -1 
End Function
 
Function onBackKey(app)
  if(app.menuConfig.stat = "visible")     
      doHideMenu(app)
      return 1           
  endif  
  return -1  
end Function


function main()     
    app = initApp()    
           
    print "loading.."
                
       prepareClip(app)             
       app.canvas.Show() 
                                               
       while true
                                                           
        event = wait(0, app.port)                        
        if (event<> invalid)
            'print "events loop"
            if (event.isRemoteKeyPressed())
                index = event.GetIndex()
                print index               
                if (index = 4) 'Left, pulls out the menu                    
                    onLeftKey(app)                                                 
                else if (index = 2) 'Up    
                    onUpKey(app)
                else if (index = 5) 'Right,  
                    onRightKey(app)                                            
                else if (index = 3) 'Down
                    onDownKey(app)                
                else if (index = 6) 'ok, Should select, if nothing is selected this shoud do it
                    onFocusItem(app)                     
                else if (index = 0) 'Back, hides the menu  
                    if(onBackKey(app) = -1)                    
                       ExitWhile
                    endif   
                endif                               
            endif
        endif           

    end while
           
    print "bye."
    return 1
End function


 
 
 
 