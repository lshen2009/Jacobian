MODULE test
  USE gckpp_Jacobian
  USE Jacobian_para
  IMPLICIT NONE

  REAL(kind=dp) :: V(206)
  REAL(kind=dp) :: F(5)
  REAL(kind=dp) :: RCT(622)
  REAL(kind=dp) :: JVS(3043)   
  V(:)=0
  F(:)=1
  RCT(:)=0.001
  JVS(:)=0
  CALL Jac_SP ( V, F, RCT, JVS )
 
END MODULE test


