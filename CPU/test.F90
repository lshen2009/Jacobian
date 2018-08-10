PROGRAM test
  USE gckpp_Jacobian
  USE Jacobian_para
  USE initialize

  IMPLICIT NONE

  REAL(4) :: V(234)
  REAL(4) :: F(5)
  REAL(4) :: RCT(724)
  REAL(4) :: JVS(3043)
  integer,parameter :: seed = 86456

  ! Initialize these vectors
  CALL initialize_1D(V)
  CALL initialize_1D(F)
  CALL initialize_1D(RCT)
  CALL initialize_1D(JVS)
  
  print *, 'this is F: ', F
  
  ! Calculate the generated jacobin matrix using old algorithm
  !V(:)=0.0
  !F(:)=1
  !RCT(:)=0.001
  !JVS(:)=0
  !CALL Jac_SP ( V, F, RCT, JVS )

END PROGRAM test




