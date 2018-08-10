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
