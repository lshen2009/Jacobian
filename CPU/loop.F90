PROGRAM test
  IMPLICIT NONE
  REAL(4) :: TimeStart,TimeEnd
  Integer :: I,J
  
  CALL CPU_TIME(time=TimeStart)
  DO I=1,300000
    DO J=1,3403
    END DO
  END DO
  CALL CPU_TIME(time=TimeEnd)
  PRINT *,'Old method time is ',TimeEnd-TimeStart
  
END PROGRAM test




