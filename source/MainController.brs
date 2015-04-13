
'************************************************************
'** Application startup
'************************************************************

'http://www.brightsign.biz/documents/BrightSignObjectReferenceManualv2.pdf

function main()     
    app = initApp()    
           
    print "loading.."
                
       prepareClip(app) ' move this into a separate module 
       paintMenu(app)       
       app.canvas.Show() 
                                               
       while true
                                                           
        event = wait(0, app.port)                        
        if (event<> invalid)
            print "events loop"
            if (event.isRemoteKeyPressed())
                index = event.GetIndex()
                print index
               
                if (index = 4) 'Left 
                    doShowMenu(app)                                     
                else if (index = 2) 'Up    
                    
                else if (index = 5) 'Right
                    doHideMenu(app)                                               
                else if (index = 3) 'Down
                                        
                else if (index = 6) 'OK                        
                   ExitWhile  
                endif
                               
            endif
        endif           

    end while
           
    print "bye."
    return 1
End function

