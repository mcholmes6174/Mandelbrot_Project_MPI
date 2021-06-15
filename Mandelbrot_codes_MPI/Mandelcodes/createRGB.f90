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
    real :: escTime, true_max, ratio, p

    allocate(R(pixel_height,local_width))
    allocate(G(pixel_height,local_width))
    allocate(B(pixel_height,local_width))
    R = 0.0; G = 0.0; B = 0.0

! MPI_ALLREDUCE(SENDBUF, RECVBUF, COUNT, DATATYPE, OP, COMM, IERROR)
    call MPI_ALLREDUCE(maxval(real(PixelArray)), true_max, 1, MPI_DOUBLE, &
                     & MPI_MAX, MPI_COMM_WORLD, ierr)
    write(*,*) 'True Max:',true_max

    ratio = 0.1257748
    p = log(0.5/true_max) / log(ratio)
    write(*,*) 'p:',p

    do j = 1,local_width
      do i = 1,pixel_height
        escTime = real(PixelArray(i,j))
        ! Set RBG values in colArray
        ratio = abs(escTime/true_max)**(1./p)
        R(i,j) = 191.0*ratio
        G(i,j) = 0.0*ratio
        B(i,j) = 255.0*ratio
      end do
    end do

  end subroutine create_colorArray

end module createRGB
