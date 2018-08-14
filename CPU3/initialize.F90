module initialize
implicit none
contains

  subroutine initialize_1D(x) 
  implicit none
     real:: x(:)
     integer :: i
     do i=1,size(x)
       x(i)=rand()
     end do
  end subroutine initialize_1D

  subroutine initialize_1D_logical(x)
  implicit none
     logical:: x(:)
     integer :: i
     do i=1,size(x)
       if (rand()>0.5) then
          x(i)=.true.
       else 
          x(i)=.true.
       endif
     end do
  end subroutine initialize_1D_logical

  subroutine zero_1D(x)
  implicit none
     real:: x(:)
     integer :: i
     do i=1,size(x)
       x(i)=0
     end do
  end subroutine zero_1D

  subroutine initialize_2D(x) 
  implicit none
     real:: x(:,:)
     integer :: d(2)
     integer :: i,j
     d=shape(x)
     do i=1,d(1)
       do j=1,d(2)
         x(i,j)=rand()
       end do
     end do   
  end subroutine initialize_2D

end module initialize
