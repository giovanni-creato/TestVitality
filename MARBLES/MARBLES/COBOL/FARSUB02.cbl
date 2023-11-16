       IDENTIFICATION DIVISION.                                                 
       PROGRAM-ID. FARSUB02.                                                    
      ******************************************************************        
      *REMARKS. BATCH COBOL SUBROUTINE - CALLED BY FARCOB01.                    
      *         PROGRAM COMPILED OBJECT ONLY (PROCESSOR COBNBO/CIINBO)          
      *         INCLUDED ON LINKCARD FARCOB01.                                  
      ******************************************************************        
       ENVIRONMENT DIVISION.                                                    
       INPUT-OUTPUT SECTION.                                                    
       FILE-CONTROL.                                                            
           SELECT PRINTOUT ASSIGN U-T-SYSOUT.                                   
       DATA DIVISION.                                                           
       FILE SECTION.                                                            
       FD  PRINTOUT                                                             
           BLOCK CONTAINS 0 RECORDS                                             
           RECORDING MODE IS F                                                  
           LABEL RECORDS ARE STANDARD                                           
           DATA RECORD IS PRINT-OUT.                                            
       01  PRINT-OUT          PIC X(133).                                       
       WORKING-STORAGE SECTION.                                                 
       01  WS-DATA  PIC X(02) VALUE 'X'.                                        
       LINKAGE  SECTION.                                                        
       COPY FARINCL.                                                            
      ******************************************************************        
       PROCEDURE DIVISION.                                                      
      ******************************************************************        
           MOVE '** CONGRATULATIONS, FARSUB02 SUCCESSFULLY EXECUTED'            
               TO COPY1-BOOK.                                                   
       STOP-RUN.                                                                
           GOBACK.                                                              
