C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV
C     SPECTRAL FINGERPRINT
C     ================================================================
C
      SUBROUTINE SPFING(EVALS,N,FPRINT,FLEN)
      DIMENSION EVALS(50), FPRINT(50)
C
      FLEN = N
      IF (N) 100,100,10
C
   10 CONTINUE
      DO 20 I=1,N
C
      E = ABS(EVALS(I))
C
      DO 30 K=1,3
      E = E * 1.6666666667E1
      E = E - IFIX(E)
      E = E * 3.1415926536E0
      E = E - IFIX(E)
   30 CONTINUE
C
      FPRINT(I) = E * 9.99999E5
   20 CONTINUE
C
  100 CONTINUE
      RETURN
      END
C
      SUBROUTINE SPFDCP(FP1,FP2,N,SIM)
      DIMENSION FP1(50), FP2(50)
C
      IF (N) 10,10,20
   10 SIM = 1.0
      GOTO 100
C
   20 CONTINUE
      MATCH = 0
      DO 30 I=1,N
      D = ABS(FP1(I) - FP2(I))
      MX = FP1(I)
      IF (FP2(I) .GT. MX) MX = FP2(I)
      IF (MX .LT. 1.0E-10) GOTO 30
      RAT = D / MX
      IF (RAT-0.01) 31,30,30
   31 MATCH = MATCH + 1
   30 CONTINUE
C
      FN = N
      SIM = MATCH / FN
C
  100 CONTINUE
      RETURN
      END
