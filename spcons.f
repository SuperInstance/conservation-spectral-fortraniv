C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV
C     CONSERVATION RATIO COMPUTATION
C     ================================================================
C
      SUBROUTINE SPCONS(EVECS,ATTR,N,IEVEC,RATIO)
      DIMENSION EVECS(50,50), ATTR(50)
      DIMENSION PROJ(50), GRAD(50)
C
      IF (N) 10,10,20
   10 RATIO = -1.0
      GOTO 100
C
   20 CONTINUE
C
      DO 30 I=1,N
      PROJ(I) = ATTR(I) * EVECS(I,IEVEC)
   30 CONTINUE
C
      IF (N-2) 40,50,50
   40 RATIO = 0.0
      GOTO 100
C
   50 NM1 = N - 1
      DO 60 I=1,NM1
      IP1 = I + 1
      GRAD(I) = PROJ(IP1) - PROJ(I)
   60 CONTINUE
C
      SUM = 0.0
      DO 70 I=1,NM1
      SUM = SUM + GRAD(I)
   70 CONTINUE
      FNM1 = NM1
      GMEAN = SUM / FNM1
C
      VAR = 0.0
      DO 80 I=1,NM1
      D = GRAD(I) - GMEAN
      VAR = VAR + D*D
   80 CONTINUE
      VAR = VAR / FNM1
C
      RATIO = VAR
C
  100 CONTINUE
      RETURN
      END
