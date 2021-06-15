module createRGB
  use parameter_reader
  use createArray
  implicit none

  real, dimension(:,:), allocatable, save :: R, G, B

contains

  subroutine create_colorArray(local_width)
    use mpi
    implicit none

    integer :: i, j, local_width, ierr
    real :: escTime, true_max, ratio

    allocate(R(pixel_height,local_width))
    allocate(G(pixel_height,local_width))
    allocate(B(pixel_height,local_width))
    R = 0.0; G = 0.0; B = 0.0

! MPI_ALLREDUCE(SENDBUF, RECVBUF, COUNT, DATATYPE, OP, COMM, IERROR)
    call MPI_ALLREDUCE(maxval(real(PixelArray)), true_max, 1, MPI_DOUBLE, &
                     & MPI_MAX, MPI_COMM_WORLD, ierr)
!    true_max = maxval(real(PixelArray))

    do j = 1,local_width
      do i = 1,pixel_height
        escTime = real(PixelArray(i,j))
        ! Set RBG values in colArray
        ratio = abs(escTime/true_max)
        ! if (ratio > 0.0) then
        !   ! we're not a member of the set
        !   colArray(i,j,1) = 178.0*(1.0-ratio)
        !   colArray(i,j,2) = 26.0*(1.0-ratio)
        !   colArray(i,j,3) = 216.0*(1.0-ratio)
        ! else
        !   ! we're a member of the set
        !   colArray(i,j,1) = 255.0
        !   colArray(i,j,2) = 255.0
        !   colArray(i,j,3) = 255.0
        ! end if
        R(i,j) = 0.0*ratio
        G(i,j) = 125.0*ratio
        B(i,j) = 255.0*ratio
      end do
    end do

  end subroutine create_colorArray

end module createRGB
