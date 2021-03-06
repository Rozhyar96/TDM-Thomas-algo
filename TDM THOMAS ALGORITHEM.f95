!!---TDM SOLVER ALGORITHEM----!!
PROGRAM TDM
IMPLICIT NONE
REAL,DIMENSION(:,:),ALLOCATABLE::A
REAL,DIMENSION(:),ALLOCATABLE::B,X
INTEGER::N
INTEGER::i,j

REAL,DIMENSION(:),ALLOCATABLE::MAINDIACOMP,UPPERDIACOMP,LOWERDIACOMP,RHO,GAMMA

PRINT*, "ENTER NUMBER OF THE UNKONOWN"
READ*,N
ALLOCATE(A(N,N))
ALLOCATE(B(N))
ALLOCATE(X(N))

ALLOCATE(MAINDIACOMP(N))
ALLOCATE(UPPERDIACOMP(N-1))
ALLOCATE(LOWERDIACOMP(N))
ALLOCATE(RHO(N))
ALLOCATE(GAMMA(N-1))

PRINT*,"ENTER THE COEFFICENT MATRIX,A"
DO i=1,N
  DO j=1,N
    READ*,A(i,j)
  END DO
END DO

PRINT*,"ENTER RHS COMPONENETS OF MATRIX"
DO i=1,N
  READ*, B(i)
END DO

DO i=1,N
  MAINDIACOMP(i)=A(i,i)
END DO

DO i=1,N-1
  UPPERDIACOMP(i)=A(i,i+1)
END DO
LOWERDIACOMP(1)=0
DO i=2,N
  LOWERDIACOMP(i)=A(i,i-1)
END DO

GAMMA(1)=UPPERDIACOMP(1)/MAINDIACOMP(1)
DO i=2,N-1
  GAMMA(i)= UPPERDIACOMP(i)/(MAINDIACOMP(i)-(LOWERDIACOMP(i)*GAMMA(i-1)))
END DO

RHO(1)=B(1)/MAINDIACOMP(1)
DO i=2,N
  RHO(i)=(B(i)-(LOWERDIACOMP(i)*RHO(i-1)))/(MAINDIACOMP(i)-(LOWERDIACOMP(i)*GAMMA(i-1)))
END DO

X(N)=RHO(N)
DO i=N-1,1,-1
  X(i)=RHO(i)-(GAMMA(i)*X(i+1))
END DO

print*,"the answer of equation is :"
DO i=1,N
  PRINT*,"X(i)=",X(i)
END DO

DEALLOCATE(A)
DEALLOCATE(B)
DEALLOCATE(X)

DEALLOCATE(MAINDIACOMP)
DEALLOCATE(UPPERDIACOMP)
DEALLOCATE(LOWERDIACOMP)
DEALLOCATE(RHO)
DEALLOCATE(GAMMA)

ENDPROGRAM TDM