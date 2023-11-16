FAPASM01 TITLE 'SAMPLE ASSEMBLER PROGRAM'                                       
***********************************************************************         
*                                                                     *         
*  PROGRAM NAME:   FAPASM01                                           *         
*                                                                     *         
*  DESCRIPTION:    SAMPLE ASSEMBLER PROGRAM.                          *         
*                                                                     *         
***********************************************************************         
         EJECT                                                                  
FAPASM01 START 0                                                                
         SAVE  (14,12),,'FAPASM01-&SYSDATE-&SYSTIME'                            
         SPACE ,                                                                
         BALR  R12,0                   COPY ENTRY POINT ADDRESS                 
         USING *,R12                   INFORM THE ASSEMBLER                     
         SPACE ,                                                                
         USING PARMAREA,R1             INFORM THE ASSEMBLER ABOUT THE  X        
                                       . PARMAREA                               
         LA    R2,SAVEAREA             GET THE PARM 3 ADDRESS                   
         ST    R13,4(R2)               SET BACK CHAIN IN NEW SAVEAREA           
         ST    R2,8(R13)               SET FORWARD CHAIN IN OLD SAVE            
         LR    R13,R2                  ESTABLISH THE CURRENT SAVEAREA           
         USING SAVEAREA,R13            INFORM THE ASSEMBLER                     
         SPACE ,                                                                
         L     R2,PARM1                LET R2 POINT TO ACTION PARM              
         L     R3,PARM2                LET R3 POINT TO DATASET NAME             
         DROP  R1                      (PARMAREA)                               
         SPACE ,                                                                
RETURN00 DS    0H                                                               
         XR    R15,R15                 SET RETURN CODE = 0                      
         B     PGMEXIT                                                          
         SPACE ,                                                                
PGMEXIT  DS    0H                                                               
         L     R13,SAVEAREA+4          GET CALLERS SAVE AREA ADDRESS            
         RETURN (14,12),,RC=(15)       RETURN                                   
         EJECT                                                                  
         LTORG                                                                  
         SPACE 3                                                                
***********************************************************************         
*                                                                     *         
*  SAVE AREA AND WORK AREA DEFINITION                                 *         
*                                                                     *         
***********************************************************************         
SAVEAREA DS    0H                                                               
         DS    18F                     RESERVE THE FIRST 18 WORDS AS            
*                                      THE ACTUAL SAVE AREA.                    
***********************************************************************         
*                                                                     *         
*  PARM AREA DEFINITION                                               *         
*                                                                     *         
***********************************************************************         
PARMAREA DSECT                                                                  
PARM1    DS    A                       ADDRESS OF ACTION PARM                   
PARM2    DS    A                       ADDRESS OF DATASET NAME                  
PARM3    DS    A                       ADDRESS OF SUPPLIED WORK AREA            
         SPACE 3                                                                
***********************************************************************         
*                                                                     *         
*  REGISTER EQUATE  DEFINITIONS                                       *         
*                                                                     *         
***********************************************************************         
R0       EQU   0                                                                
R1       EQU   1                                                                
R2       EQU   2                                                                
R3       EQU   3                                                                
R4       EQU   4                                                                
R5       EQU   5                                                                
R6       EQU   6                                                                
R7       EQU   7                                                                
R8       EQU   8                                                                
R9       EQU   9                                                                
R10      EQU   10                                                               
R11      EQU   11                                                               
R12      EQU   12                                                               
R13      EQU   13                                                               
R14      EQU   14                                                               
R15      EQU   15                                                               
         SPACE 3                                                                
***********************************************************************         
*                                                                     *         
*  ADDED SOME LINES TO SHOW HISTORE OF UPDATES                        *         
*                                                                     *         
***********************************************************************         
         END                                                                    
