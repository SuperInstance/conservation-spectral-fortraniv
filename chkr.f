C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV
C     CHEEGER CONSTANT APPROXIMATION
C     ================================================================
C
      SUBROUTINE SPCHKR(LAP,FIEDL,N,CHEEG)
      REAL LAP
      DIMENSION LAP(50,50), FIEDL(50)
      DIMENSION INS(50)
C
      IF (N-2) 10,10,20
   10 CHEEG = 0.0
      GOTO 100
C
   20 CONTINUE
      DO 30 I=1,N
      IF (FIEDL(I)) 31,32,32
   31 INS(I) = 1
      GOTO 30
   32 INS(I) = 0
   30 CONTINUE
C
      CUT = 0.0
      VOL = 0.0
      TOTVOL = 0.0
C
      DO 40 I=1,N
      TOTVOL = TOTVOL + LAP(I,I)
      IF (INS(I)) 41,40,41
   41 CONTINUE
      VOL = VOL + LAP(I,I)
      DO 42 J=1,N
      IF (I-J) 43,42,43
   43 IF (INS(J)) 42,42,44
   44 CONTINUE
      CUT = CUT - LAP(J,I)
   42 CONTINUE
   40 CONTINUE
C
      VOLC = TOTVOL - VOL
      MINV = VOL
      IF (VOLC .LT. VOL) MINV = VOLC
C
      IF (MINV .LT. 1.0E-15) GOTO 50
      CHEEG = CUT / MINV
      GOTO 100
C
   50 CHEEG = 0.0
C
  100 CONTINUE
      RETURN
      END
