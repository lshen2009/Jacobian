PROGRAM test
  USE Jacobian_fun_old
  USE Jacobian_fun_new
  USE Jacobian_para
  USE initialize

  IMPLICIT NONE
  integer,parameter :: seed = 86456
  REAL(4) :: V(234)
  REAL(4) :: F(5)
  REAL(4) :: RCT(724)
  REAL(4) :: JVS(3413)
  REAL(4) :: TimeStart,TimeEnd,time1,time2
  LOGICAL :: ind(3413)
  INTEGER :: I
  ! Initialize these vectors
  CALL initialize_1D(V)
  CALL initialize_1D(F)
  CALL initialize_1D(RCT)
  CALL zero_1D(JVS)
  CALL initialize_1D_logical(ind)
  
  !print *, 'this is F: ', F
  
  ! Calculate the generated jacobin matrix using old algorithm
  CALL CPU_TIME(time=TimeStart)
  DO I=1,100000
    CALL Jac_SP_old ( V, F, RCT, JVS )
  END DO
  CALL CPU_TIME(time=TimeEnd)
  time1=TimeEnd-TimeStart

  ! Calculate the generated jacobin matrix using new algorithm
  CALL zero_1D(JVS)
  CALL CPU_TIME(time=TimeStart)
  DO I=1,100000
    !CALL zero_1D(JVS)
    CALL Jac_SP_new ( V, F, RCT, JVS,ind)
  END DO
  CALL CPU_TIME(time=TimeEnd)
  time2=TimeEnd-TimeStart  

  print *,time1,time2 
END PROGRAM test




