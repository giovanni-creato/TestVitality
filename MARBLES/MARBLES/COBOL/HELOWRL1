       IDENTIFICATION DIVISION.                                         00010002
       PROGRAM-ID. HELOWRL1.                                            00020002
      ******************************************************************00030002
      *REMARKS.  BATCH COBOL PROGRAM.                                   00040002
      *          USE PROCESSOR GROUP MARBLES.                           00050002
      ******************************************************************00060002
      ****** COMMENTS SECTION ******************************************00070002
      * THIS IS THE ELEMENT IN PRD.                                    *00080002
      * THIS IS THE ELEMENT THAT WILL BE ADDED TO QA.                  *00081003
      ******************************************************************00090002
       ENVIRONMENT DIVISION.                                            00100002
       INPUT-OUTPUT SECTION.                                            00110002
       FILE-CONTROL.                                                    00120002
       DATA DIVISION.                                                   00130002
      ******************************************************************00140002
       WORKING-STORAGE SECTION.                                         00150002
      ******************************************************************00160002
       COPY FAPHDR.                                                     00170002
       01  PROGRAM-WORK-FIELDS.                                         00180002
           02  INPUT-SWITCH      PIC X(3).                              00190002
               88  END-OF-FILE   VALUE 'EOX'.                           00200002
           02  LINES-WRITTEN     PIC 9(3).                              00210002
               88  NEW-PAGE      VALUE 30.                              00220002
           02  PAGE-COUNT        PIC 9(3).                              00230002
       COPY FAPPAGE.                                                    00240002
       01  DATA-LINE.                                                   00250002
           02  FILLER                PIC X(5).                          00260002
           02  OUTPUT-FIELD1         PIC ZZ,ZZZ,ZZ9.                    00270002
           02  FILLER                PIC X(7).                          00280002
           02  OUTPUT-FIELD2         PIC X(10).                         00290002
           02  FILLER                PIC X(5).                          00300002
           02  OUTPUT-FIELD3         PIC X(20).                         00310002
           02  FILLER                PIC X(6).                          00320002
           02  OUTPUT-FIELD4         PIC ZZZ,ZZ9.                       00330002
           02  FILLER                PIC X(5).                          00340002
           02  OUTPUT-FIELD5         PIC ZZZ,ZZ9.                       00350002
           02  FILLER                PIC X(5).                          00360002
           02  OUTPUT-TOTAL          PIC ZZZ,ZZZ,ZZZ,ZZZ,ZZ9.           00370002
           02  FILLER                PIC X(30).                         00380002
       COPY FOOTER.                                                     00390002
      ******************************************************************00400002
       PROCEDURE DIVISION.                                              00410002
      ******************************************************************00420002
           DISPLAY 'HELLO WORLD'.                                       00430002
           GOBACK.                                                      00440002
