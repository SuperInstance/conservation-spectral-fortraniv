C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV
C     SPECTRAL GAP COMPUTATION
C     ================================================================
C
      SUBROUTINE SPSGAP(EVALS,N,SGAP)
      DIMENSION EVALS(50)
C
      IF (N-2) 10,10,20
   10 SGAP = 0.0
      GOTO 100
C
   20 CONTINUE
      SGAP = 0.0
      NM1 = N - 1
      DO 30 I=1,NM1
      IP1 = I + 1
      GAP = EVALS(IP1) - EVALS(I)
      IF (GAP .GT. SGAP) SGAP = GAP
   30 CONTINUE
C
  100 CONTINUE
      RETURN
      END
