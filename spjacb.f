C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV (1960S STYLE)
C     JACOBI EIGENDECOMPOSITION (1846 ALGORITHM)
C     ================================================================
C
      SUBROUTINE SPJACB(A,N,EVALS,EVECS,MAXIT,IERR)
      DIMENSION A(50,50), EVALS(50), EVECS(50,50)
C
C     INITIALIZE EIGENVECTOR MATRIX TO IDENTITY
C
      DO 10 I=1,N
      DO 10 J=1,N
      IF (I-J) 11,12,11
   11 EVECS(J,I) = 0.0
      GOTO 10
   12 EVECS(J,I) = 1.0
   10 CONTINUE
C
      IERR = 0
C
C     MAIN ITERATION LOOP
C
      DO 100 ITERS=1,MAXIT
C
C     COMPUTE OFF-DIAGONAL NORM
C
      OFFDIA = 0.0
      DO 110 I=2,N
      IM1 = I - 1
      DO 110 J=1,IM1
      OFFDIA = OFFDIA + A(J,I)*A(J,I)
  110 CONTINUE
      IF (OFFDIA) 120,200,120
  120 CONTINUE
      IF (OFFDIA .LT. 1.0E-14) GOTO 200
C
C     SWEEP ALL OFF-DIAGONAL PAIRS
C
      DO 130 IP=2,N
      IPM1 = IP - 1
      DO 130 IQ=1,IPM1
      IF (ABS(A(IQ,IP)) .LT. 1.0E-15) GOTO 130
C
      APQ = A(IQ,IP)
      AIQ = A(IQ,IQ)
      API = A(IP,IP)
C
      DIFF = API - AIQ
      IF (ABS(DIFF) .LT. 1.0E-30) GOTO 140
      TAU = DIFF / (2.0 * APQ)
C
      IF (TAU) 141,142,143
  141 T = -1.0 / (ABS(TAU) + SQRT(1.0+TAU*TAU))
      GOTO 144
  142 T = 1.0
      GOTO 144
  143 T = 1.0 / (ABS(TAU) + SQRT(1.0+TAU*TAU))
      GOTO 144
C
  140 T = 1.0
C
  144 CONTINUE
      C = 1.0 / SQRT(1.0 + T*T)
      S = T * C
      TAU2 = S / (1.0 + C)
C
C     UPDATE DIAGONAL AND ZERO OFF-DIAGONAL
C
      A(IQ,IQ) = AIQ - T * APQ
      A(IP,IP) = API + T * APQ
      A(IQ,IP) = 0.0
C
C     UPDATE REMAINING ROWS/COLUMNS
C
      DO 150 I=1,N
      IF (I-IQ) 151,150,151
      IF (I-IP) 151,150,151
  151 CONTINUE
      AI = A(I,IQ)
      AJ = A(I,IP)
      A(I,IQ) = AI - S*(AJ + TAU2*AI)
      A(I,IP) = AJ + S*(AI - TAU2*AJ)
  150 CONTINUE
C
C     ACCUMULATE EIGENVECTORS
C
      DO 160 I=1,N
      EI = EVECS(I,IQ)
      EJ = EVECS(I,IP)
      EVECS(I,IQ) = EI - S*(EJ + TAU2*EI)
      EVECS(I,IP) = EJ + S*(EI - TAU2*EJ)
  160 CONTINUE
C
  130 CONTINUE
  100 CONTINUE
C
      IERR = 1
      GOTO 210
C
C     CONVERGED - EXTRACT AND SORT EIGENVALUES
C
  200 CONTINUE
      DO 170 I=1,N
      EVALS(I) = A(I,I)
  170 CONTINUE
C
C     BUBBLE SORT ASCENDING
C
      IF (N) 210,210,180
  180 CONTINUE
      NM1 = N - 1
      DO 190 I=1,NM1
      IP1 = I + 1
      DO 190 J=IP1,N
      IF (EVALS(I) .LE. EVALS(J)) GOTO 190
C
      TEMP = EVALS(I)
      EVALS(I) = EVALS(J)
      EVALS(J) = TEMP
C
      DO 195 K=1,N
      TEMP = EVECS(K,I)
      EVECS(K,I) = EVECS(K,J)
      EVECS(K,J) = TEMP
  195 CONTINUE
C
  190 CONTINUE
C
  210 CONTINUE
      RETURN
      END
