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
  REAL(4) :: TimeStart,TimeEnd
  Integer :: I
  ! Initialize these vectors
  CALL initialize_1D(V)
  CALL initialize_1D(F)
  CALL initialize_1D(RCT)
  CALL zero_1D(JVS)
  
  !print *, 'this is F: ', F
  
  ! Calculate the generated jacobin matrix using old algorithm
  CALL CPU_TIME(time=TimeStart)
  DO I=1,100000
    CALL Jac_SP_old ( V, F, RCT, JVS )
  END DO
  CALL CPU_TIME(time=TimeEnd)
  PRINT *,'Old method time is ',TimeEnd-TimeStart

  ! Calculate the empty loops
  CALL CPU_TIME(time=TimeStart)
  DO I=1,100000
    CALL test_empty_loop()
  END DO
  CALL CPU_TIME(time=TimeEnd)
  PRINT *,'Empty loop time is ',TimeEnd-TimeStart

  ! Calculate the generated jacobin matrix using new algorithm
  CALL CPU_TIME(time=TimeStart)
  CALL zero_1D(JVS)
  DO I=1,100000
    !CALL zero_1D(JVS)
    CALL Jac_SP_new ( V, F, RCT, JVS )
  END DO
  CALL CPU_TIME(time=TimeEnd)
  PRINT *,'New method time is ',TimeEnd-TimeStart  

  !Now I add timers to test the time used
  
END PROGRAM test




