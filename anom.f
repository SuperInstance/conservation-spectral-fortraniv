C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV (1960S STYLE)
C     ANOMALY DETECTION (SLIDING WINDOW)
C     ================================================================
C
      SUBROUTINE SPANMI(WSIZE)
      COMMON /SPTRK/ SPHIST(100), SPMEAN, SPSTDV, SPCNT, SPWIND
C
      SPWIND = WSIZE
      SPCNT = 0
      SPMEAN = 0.0
      SPSTDV = 0.0
      DO 10 I=1,100
      SPHIST(I) = 0.0
   10 CONTINUE
      RETURN
      END
C
      SUBROUTINE SPANOM(OBS,ISTAT)
      COMMON /SPTRK/ SPHIST(100), SPMEAN, SPSTDV, SPCNT, SPWIND
C
      ISTAT = 0
      IWIND = IFIX(SPWIND + 0.5)
      ICNT = IFIX(SPCNT + 0.5)
C
      IF (ICNT-IWIND) 10,20,20
C
   10 CONTINUE
      ICNT = ICNT + 1
      SPHIST(ICNT) = OBS
      SPCNT = ICNT
C
      IF (ICNT-IWIND) 100,30,30
C
   30 CONTINUE
      SUM = 0.0
      DO 40 I=1,IWIND
      SUM = SUM + SPHIST(I)
   40 CONTINUE
      FIW = IWIND
      SPMEAN = SUM / FIW
C
      VAR = 0.0
      DO 50 I=1,IWIND
      D = SPHIST(I) - SPMEAN
      VAR = VAR + D*D
   50 CONTINUE
      VAR = VAR / FIW
      SPSTDV = SQRT(VAR)
      ISTAT = 0
      GOTO 100
C
   20 CONTINUE
      DO 60 I=2,IWIND
      IM1 = I - 1
      SPHIST(IM1) = SPHIST(I)
   60 CONTINUE
      SPHIST(IWIND) = OBS
C
      IF (SPSTDV .LT. 1.0E-15) GOTO 100
C
      ZSCORE = ABS(OBS - SPMEAN) / SPSTDV
C
      IF (ZSCORE-3.0) 70,80,90
   70 IF (ZSCORE-2.0) 100,80,80
   80 ISTAT = 1
      GOTO 100
   90 ISTAT = 2
C
  100 CONTINUE
      RETURN
      END
