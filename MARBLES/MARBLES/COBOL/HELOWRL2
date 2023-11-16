       IDENTIFICATION DIVISION.                                         00010000
       PROGRAM-ID. HELOWRL2.                                            00020000
      ******************************************************************00030000
      *REMARKS.  BATCH COBOL PROGRAM.                                   00040000
      *          USE PROCESSOR GROUP MARBLES.                           00050000
      ******************************************************************00060000
      ****** COMMENTS SECTION ******************************************00070000
      * THIS IS THE ELEMENT THAT WILL BE ADDED TO QA STAGE 1 FOR       *00081000
      * JUMP OPTION.                                                   *00081100
      ******************************************************************00082000
       ENVIRONMENT DIVISION.                                            00083000
       INPUT-OUTPUT SECTION.                                            00084000
       FILE-CONTROL.                                                    00085000
       DATA DIVISION.                                                   00086000
      ******************************************************************00087000
       WORKING-STORAGE SECTION.                                         00088000
      ******************************************************************00089000
       COPY FAPHDR.                                                     00090000
       01  PROGRAM-WORK-FIELDS.                                         00100000
           02  INPUT-SWITCH      PIC X(3).                              00110000
               88  END-OF-FILE   VALUE 'EOX'.                           00120000
           02  LINES-WRITTEN     PIC 9(3).                              00130000
               88  NEW-PAGE      VALUE 30.                              00140000
           02  PAGE-COUNT        PIC 9(3).                              00150000
       COPY FAPPAGE.                                                    00160000
       01  DATA-LINE.                                                   00170000
           02  FILLER                PIC X(5).                          00180000
           02  OUTPUT-FIELD1         PIC ZZ,ZZZ,ZZ9.                    00190000
           02  FILLER                PIC X(7).                          00200000
           02  OUTPUT-FIELD2         PIC X(10).                         00210000
           02  FILLER                PIC X(5).                          00220000
           02  OUTPUT-FIELD3         PIC X(20).                         00230000
           02  FILLER                PIC X(6).                          00240000
           02  OUTPUT-FIELD4         PIC ZZZ,ZZ9.                       00250000
           02  FILLER                PIC X(5).                          00260000
           02  OUTPUT-FIELD5         PIC ZZZ,ZZ9.                       00270000
           02  FILLER                PIC X(5).                          00280000
           02  OUTPUT-TOTAL          PIC ZZZ,ZZZ,ZZZ,ZZZ,ZZ9.           00290000
           02  FILLER                PIC X(30).                         00300000
       COPY FOOTER.                                                     00310000
      ******************************************************************00320000
       PROCEDURE DIVISION.                                              00330000
      ******************************************************************00340000
           DISPLAY 'HELLO WORLD'.                                       00350000
           GOBACK.                                                      00360000
