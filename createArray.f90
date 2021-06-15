module createArray
  use parameter_reader
  implicit none

  complex, dimension(:,:), allocatable, save :: PixelArray

contains

  subroutine create_pixelArray(local_width, local_xL, local_xR)
    implicit none

    real :: Xstep, Ystep, local_xL, local_xR
    integer :: i, j, local_width

    allocate(PixelArray(pixel_height,local_width))
    PixelArray = cmplx(0.0)

    Xstep = (local_xR-local_xL)/(local_width-1)
    Ystep = (y_max-y_min)/(pixel_height-1)

    ! Fill array with complex entries
    do j = 1,local_width
      do i = 1,pixel_height
        PixelArray(i,j) = cmplx( local_xL + Xstep*real(j-1), &
                                  & y_max - Ystep*real(i-1) )
      end do
    end do

  end subroutine create_pixelArray

end module createArray
