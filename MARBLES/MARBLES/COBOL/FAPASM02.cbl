FAPASM02 TITLE 'SAMPLE ASSEMBLER MODULE'                                        
***********************************************************************         
*                                                                     *         
*  MODULE  NAME:   FAPASM02                                           *         
*                                                                     *         
*  DESCRIPTION:    SAMPLE ASSEMBLER MODULE USING MACROS               *         
*                                                                     *         
***********************************************************************         
          @GRPSEQ SUBSYS=LBS0,GRP=LBXS,SEQ=0                                    
          @GRPSEQ SUBSYS=LBS0,GRP=LBYS,SEQ=1                                    
          @GRPSEQ SUBSYS=LBS0,GRP=LBZS,SEQ=2                                    
          @GRPSEQ SUBSYS=LBXS,GRP=LBXS,SEQ=0                                    
          @GRPSEQ SUBSYS=LBXS,GRP=LBYS,SEQ=1                                    
          @GRPSEQ SUBSYS=LBXS,GRP=LBZS,SEQ=2                                    
          @GRPSEQ SUBSYS=LBYS,GRP=LBYS,SEQ=0                                    
          @GRPSEQ SUBSYS=LBZS,GRP=LBYS,SEQ=0                                    
          @GRPSEQ SUBSYS=LBZS,GRP=LBXS,SEQ=1                                    
          @GRPSEQ SUBSYS=LBZS,GRP=LBZS,SEQ=2                                    
          @GRPSEQ ENTRY=END                                                     
          END                                                                   
