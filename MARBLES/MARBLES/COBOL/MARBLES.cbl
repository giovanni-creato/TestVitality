      * ===============================================================         
      * The user invokes this transaction (called MRBL) via:                    
      *   MRBL <VERB> <COLOR>                                                   
      *                                                                         
      * Where:                                                                  
      *  <VERB> = ADD|SUB                                                       
      * And:                                                                    
      *  <COLOR> = RED|BLUE                                                     
      *                                                                         
      * Example:                                                                
      *  MRBL ADD BLUE                                                          
      *                                                                         
      * Build via                                                               
      *  gulp build --source marbles.cbl && gulp refresh --source marbles.cbl   
      * ===============================================================         
       IDENTIFICATION DIVISION.                                                 
       PROGRAM-ID. MARBLES.                                                     
       ENVIRONMENT DIVISION.                                                    
       DATA DIVISION.                                                           
      * ===============================================================         
      * Map input / output areas                                                
      * ===============================================================         
       WORKING-STORAGE SECTION.                                                 
       01 WS-WORK.                                                              
          02 WS-WORK-INV PIC S9(4) COMP VALUE 0.                                
          02 WS-WORK-INV-DISPLAY PIC 9(4) VALUE 0.                              
          02 WS-WORK-COLOR PIC X(10).                                           
          02 WS-WORK-ROW-COUNT PIC S9(4) COMP-3 VALUE 0.                        
          02 WS-COLOR-FOUND PIC 9 VALUE 0.                                      
          02 WS-KNOWN-VERB PIC 9 VALUE 0.                                       
          02 WS-VERB-ADD PIC 9 VALUE 0.                                         
          02 WS-VERB-SUB PIC 9 VALUE 0.                                         
          02 WS-VERB-GET PIC 9 VALUE 0.                                         
          02 WS-VERB-INIT PIC 9 VALUE 0.                                        
          02 WS-VERB-CREATE PIC 9 VALUE 0.                                      
          02 WS-VERB-DELETE PIC 9 VALUE 0.                                      
       01 WS-CONST.                                                             
          02 WS-CONST-ADD PIC X(3) VALUE 'ADD'.                                 
          02 WS-CONST-SUB PIC X(3) VALUE 'SUB'.                                 
          02 WS-CONST-INIT PIC X(3) VALUE 'INI'.                                
          02 WS-CONST-GET PIC X(3) VALUE 'GET'.                                 
          02 WS-CONST-CREATE PIC X(3) VALUE 'CRE'.                              
          02 WS-CONST-DELETE PIC X(3) VALUE 'DEL'.                              
       01 WS-INPUT.                                                             
          05 WS-INPUT-TRAN-ID PIC X(4).                                         
          05 WS-INPUT-FIRST-SPACE PIC X(1) VALUE SPACES.                        
          05 WS-INPUT-VERB PIC X(3) VALUE SPACES.                               
          05 WS-INPUT-SECOND-SPACE2 PIC X(1) VALUE SPACES.                      
          05 WS-INPUT-COLOR PIC X(10) VALUE SPACES.                             
          05 WS-INPUT-FILLER PIC X(51).                                         
       01 WS-OUTPUT.                                                            
          05 WS-OUTPUT-TEXT PIC X(78).                                          
       01 WS-MSG-LENGTH PIC S9(4) COMP.                                         
      * ===============================================================         
      * Map SQL table for this transaction                                      
      * ===============================================================         
           EXEC SQL DECLARE EVENT.MARBLES TABLE                                 
           ( COLOR                          VARCHAR(10) NOT NULL,               
             INVENTORY                      INTEGER NOT NULL                    
           ) END-EXEC.                                                          
           EXEC SQL INCLUDE SQLCA END-EXEC.                                     
      * ===============================================================         
      * MRBL transaction                                                        
      * ===============================================================         
       PROCEDURE DIVISION.                                                      
      *                                                                         
      *     Initial working storage to known values                             
      *                                                                         
            PERFORM INIT-WORK-AREAS.                                            
      *                                                                         
      *     Receive user input (e.g. ADD BLUE)                                  
      *                                                                         
            PERFORM GET-TRANS-INPUT.                                            
      *                                                                         
      *     Verify known input verb                                             
      *                                                                         
            PERFORM VERIFY-VERB.                                                
      *                                                                         
      *     Route to specific verb processing routine                           
      *     TODO(Kelosky): every verb should be recorded in hyperledger!        
      *                                                                         
            IF WS-VERB-ADD = 1 THEN                                             
                PERFORM CHECK-IF-COLOR-FOUND                                    
                IF WS-COLOR-FOUND = 1 THEN                                      
                    PERFORM DO-ADD                                              
                END-IF                                                          
            ELSE IF WS-VERB-SUB = 1 THEN                                        
                PERFORM CHECK-IF-COLOR-FOUND                                    
                IF WS-COLOR-FOUND = 1 THEN                                      
                    PERFORM DO-SUB                                              
                END-IF                                                          
            ELSE IF WS-VERB-GET = 1 THEN                                        
                PERFORM CHECK-IF-COLOR-FOUND                                    
                IF WS-COLOR-FOUND = 1 THEN                                      
                    PERFORM DO-GET                                              
                END-IF                                                          
            ELSE IF WS-VERB-INIT = 1 THEN                                       
                PERFORM CHECK-IF-COLOR-FOUND                                    
                IF WS-COLOR-FOUND = 1 THEN                                      
                    PERFORM DO-INIT                                             
                END-IF                                                          
            ELSE IF WS-VERB-DELETE = 1 THEN                                     
                PERFORM CHECK-IF-COLOR-FOUND                                    
                IF WS-COLOR-FOUND = 1 THEN                                      
                    PERFORM DO-DELETE                                           
                END-IF                                                          
            ELSE IF WS-VERB-CREATE = 1 THEN                                     
                PERFORM CHECK-IF-COLOR-FOUND                                    
                IF WS-COLOR-FOUND = 0 THEN                                      
                    PERFORM DO-CREATE                                           
                ELSE                                                            
                    PERFORM DO-GET                                              
                END-IF                                                          
            END-IF.                                                             
            PERFORM WRITE-OUTPUT                                                
                                                                                
            GOBACK.                                                             
      * ===============================================================         
      * Initialize working areas                                                
      * ===============================================================         
       INIT-WORK-AREAS.                                                         
      *                                                                         
      *     Set work areas to known values                                      
      *                                                                         
            INITIALIZE SQLCA.                                                   
            MOVE 74 TO WS-MSG-LENGTH.                                           
            MOVE SPACES TO WS-INPUT.                                            
            MOVE SPACES TO WS-OUTPUT-TEXT.                                      
      * ===============================================================         
      * Write transaction response to user                                      
      * ===============================================================         
       WRITE-OUTPUT.                                                            
      *                                                                         
      *     Send response to terminal                                           
      *                                                                         
            EXEC CICS SEND                                                      
                        FROM(WS-OUTPUT-TEXT)                                    
                        LENGTH(WS-MSG-LENGTH)                                   
                        ERASE                                                   
            END-EXEC.                                                           
      * ===============================================================         
      * Get transaction input                                                   
      * ===============================================================         
       GET-TRANS-INPUT.                                                         
      *                                                                         
      *     Receive input from user                                             
      *                                                                         
            EXEC CICS RECEIVE                                                   
                        INTO(WS-INPUT)                                          
                        LENGTH(WS-MSG-LENGTH)                                   
            END-EXEC.                                                           
      * ===============================================================         
      * Set indicator if verb is invalid                                        
      * ===============================================================         
       VERIFY-VERB.                                                             
      *                                                                         
      *     Get count of rows on input color                                    
      *                                                                         
            IF WS-CONST-ADD = WS-INPUT-VERB THEN                                
                MOVE 1 TO WS-VERB-ADD                                           
                MOVE 1 TO WS-KNOWN-VERB                                         
            ELSE IF WS-CONST-SUB = WS-INPUT-VERB THEN                           
                MOVE 1 TO WS-VERB-SUB                                           
                MOVE 1 TO WS-KNOWN-VERB                                         
            ELSE IF WS-CONST-GET = WS-INPUT-VERB THEN                           
                MOVE 1 TO WS-VERB-GET                                           
                MOVE 1 TO WS-KNOWN-VERB                                         
            ELSE IF WS-CONST-INIT = WS-INPUT-VERB THEN                          
                MOVE 1 TO WS-VERB-INIT                                          
                MOVE 1 TO WS-KNOWN-VERB                                         
            ELSE IF WS-CONST-CREATE = WS-INPUT-VERB THEN                        
                MOVE 1 TO WS-VERB-CREATE                                        
                MOVE 1 TO WS-KNOWN-VERB                                         
            ELSE IF WS-CONST-DELETE = WS-INPUT-VERB THEN                        
                MOVE 1 TO WS-VERB-DELETE                                        
                MOVE 1 TO WS-KNOWN-VERB                                         
            ELSE                                                                
                MOVE 0 TO WS-KNOWN-VERB                                         
                MOVE 41 TO WS-MSG-LENGTH                                        
                MOVE 'USE ADD|SUB|GET|INI|CRE|DEL' TO WS-OUTPUT-TEXT            
            END-IF                                                              
      *                                                                         
      *     If positive row count, mark "found" indicator                       
      *                                                                         
            IF WS-WORK-ROW-COUNT > 0 THEN                                       
              MOVE 1 TO WS-COLOR-FOUND                                          
            END-IF.                                                             
      * ===============================================================         
      * Set indicator if input color is found                                   
      * ===============================================================         
       CHECK-IF-COLOR-FOUND.                                                    
      *                                                                         
      *     Get count of rows on input color                                    
      *                                                                         
            EXEC SQL                                                            
                SELECT COUNT(*) INTO :WS-WORK-ROW-COUNT                         
                FROM EVENT.MARBLES                                              
                WHERE COLOR = :WS-INPUT-COLOR                                   
            END-EXEC.                                                           
      *                                                                         
      *     If positive row count, mark "found" indicator                       
      *                                                                         
            IF WS-WORK-ROW-COUNT > 0 THEN                                       
                MOVE 1 TO WS-COLOR-FOUND                                        
            ELSE                                                                
                MOVE 0 TO WS-COLOR-FOUND                                        
                MOVE 24 TO WS-MSG-LENGTH                                        
                MOVE 'UNKNOWN COLOR, CREate IT' TO WS-OUTPUT-TEXT               
            END-IF.                                                             
      * ===============================================================         
      * Update current inventory                                                
      * ===============================================================         
       UPDATE-INVENTORY.                                                        
      *                                                                         
      *    Set current inventory into WS-WORK-INV                               
      *                                                                         
           EXEC SQL                                                             
               UPDATE EVENT.MARBLES                                             
               SET INVENTORY = :WS-WORK-INV                                     
               WHERE COLOR = :WS-INPUT-COLOR                                    
           END-EXEC.                                                            
      * ===============================================================         
      * Get current inventory                                                   
      * ===============================================================         
       GET-INVENTORY.                                                           
      *                                                                         
      *    Set current inventory into WS-WORK-INV                               
      *                                                                         
           EXEC SQL                                                             
               SELECT INVENTORY INTO :WS-WORK-INV                               
               FROM EVENT.MARBLES                                               
               WHERE COLOR = :WS-INPUT-COLOR                                    
           END-EXEC.                                                            
      * ===============================================================         
      * Insert color                                                            
      * ===============================================================         
       INSERT-COLOR.                                                            
      *                                                                         
      *    Set current inventory into WS-WORK-INV                               
      *                                                                         
           EXEC SQL                                                             
               INSERT INTO EVENT.MARBLES                                        
               VALUES (                                                         
                     :WS-INPUT-COLOR,                                           
                     0)                                                         
           END-EXEC.                                                            
      * ===============================================================         
      * Delete color                                                            
      * ===============================================================         
       DELETE-COLOR.                                                            
      *                                                                         
      *    Set current inventory into WS-WORK-INV                               
      *                                                                         
           EXEC SQL                                                             
               DELETE FROM EVENT.MARBLES                                        
               WHERE COLOR = :WS-INPUT-COLOR                                    
           END-EXEC.                                                            
      * ===============================================================         
      * Do create transaction                                                   
      * ===============================================================         
       DO-CREATE.                                                               
      *                                                                         
      *     Get the current inventor                                            
      *                                                                         
            PERFORM INSERT-COLOR.                                               
      *                                                                         
      *     Set message                                                         
      *                                                                         
            MOVE 4 TO WS-MSG-LENGTH                                             
            MOVE 0 TO WS-WORK-INV-DISPLAY                                       
            MOVE WS-WORK-INV-DISPLAY TO WS-OUTPUT-TEXT.                         
      * ===============================================================         
      * Do delete transaction                                                   
      * ===============================================================         
       DO-DELETE.                                                               
      *                                                                         
      *     Get the current inventor                                            
      *                                                                         
            PERFORM DELETE-COLOR                                                
      *                                                                         
      *     Set message                                                         
      *                                                                         
            MOVE 4 TO WS-MSG-LENGTH                                             
            MOVE 0 TO WS-WORK-INV-DISPLAY                                       
            MOVE WS-WORK-INV-DISPLAY TO WS-OUTPUT-TEXT.                         
      * ===============================================================         
      * Do get transaction                                                      
      * ===============================================================         
       DO-GET.                                                                  
      *                                                                         
      *     Get the current inventor                                            
      *                                                                         
            PERFORM GET-INVENTORY                                               
      *                                                                         
      *     Set message                                                         
      *                                                                         
            MOVE 4 TO WS-MSG-LENGTH                                             
            MOVE WS-WORK-INV TO WS-WORK-INV-DISPLAY                             
            MOVE WS-WORK-INV-DISPLAY TO WS-OUTPUT-TEXT.                         
      * ===============================================================         
      * Do init transaction                                                     
      * ===============================================================         
       DO-INIT.                                                                 
      *                                                                         
      *     Clear                                                               
      *                                                                         
            MOVE 0 TO WS-WORK-INV                                               
      *                                                                         
      *     Update inventory                                                    
      *                                                                         
            PERFORM UPDATE-INVENTORY                                            
      *                                                                         
      *     Set message                                                         
      *                                                                         
            MOVE 4 TO WS-MSG-LENGTH                                             
            MOVE WS-WORK-INV TO WS-WORK-INV-DISPLAY                             
            MOVE WS-WORK-INV-DISPLAY TO WS-OUTPUT-TEXT.                         
      * ===============================================================         
      * Do add transaction                                                      
      * ===============================================================         
       DO-ADD.                                                                  
      *                                                                         
      *     Get the current inventor                                            
      *                                                                         
            PERFORM GET-INVENTORY                                               
      *                                                                         
      *     Add                                                                 
      *                                                                         
            ADD 1 TO WS-WORK-INV                                                
      *                                                                         
      *     Update inventory                                                    
      *                                                                         
            PERFORM UPDATE-INVENTORY                                            
      *                                                                         
      *     Set message                                                         
      *                                                                         
            MOVE 4 TO WS-MSG-LENGTH                                             
            MOVE WS-WORK-INV TO WS-WORK-INV-DISPLAY                             
            MOVE WS-WORK-INV-DISPLAY TO WS-OUTPUT-TEXT.                         
      * ===============================================================         
      * Do subtract transaction                                                 
      * ===============================================================         
       DO-SUB.                                                                  
      *                                                                         
      *     Get the current inventor                                            
      *                                                                         
            PERFORM GET-INVENTORY                                               
      *                                                                         
      *     Subtract (only subtract if we dont go negative)                     
      *                                                                         
            IF WS-WORK-INV > 0 THEN                                             
                SUBTRACT 1 FROM WS-WORK-INV                                     
            END-IF                                                              
      *                                                                         
      *     Update inventory                                                    
      *                                                                         
           PERFORM UPDATE-INVENTORY                                             
      *                                                                         
      *     Set message                                                         
      *                                                                         
            MOVE 4 TO WS-MSG-LENGTH                                             
            MOVE WS-WORK-INV TO WS-WORK-INV-DISPLAY                             
            MOVE WS-WORK-INV-DISPLAY TO WS-OUTPUT-TEXT.                         
