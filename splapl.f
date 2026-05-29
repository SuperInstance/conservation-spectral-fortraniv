C     ================================================================
C     CONSERVATION SPECTRAL SDK - FORTRAN IV (1960S STYLE)
C     BUILD LAPLACIAN FROM TRANSITION/ADJACENCY MATRIX
C     ================================================================
C
C     COMMON BLOCK FOR MAXIMUM DIMENSION
C
      SUBROUTINE SPLAPL(TRANS,N,LPLC)
      REAL LPLC
      DIMENSION TRANS(50,50), LPLC(50,50)
C
      DO 10 I=1,N
      SUM = 0.0
      DO 20 J=1,N
   20 SUM = SUM + TRANS(J,I)
      DO 30 J=1,N
      IF (I-J) 31,32,31
   31 LPLC(J,I) = -TRANS(J,I)
      GOTO 30
   32 LPLC(J,I) = SUM
   30 CONTINUE
   10 CONTINUE
      RETURN
      END
