module createMandel
  use Mandel_funcs
  use createArray
  implicit none

contains

  subroutine run_createMandel(local_width)
    implicit none

    integer :: i, j, local_width
    real    :: time2esc

    do j = 1,local_width
      do i = 1,pixel_height
        if (cabs(PixelArray(i,j)) > 0.25) then
          time2esc = 0.0
          call escTime(PixelArray(i,j),time2esc)
          ! replace a+bi by escTime+0.0i
          PixelArray(i,j) = cmplx(time2esc)
        else
          PixelArray(i,j) = cmplx(0.0)
        end if
      end do
    end do

  end subroutine run_createMandel

end module createMandel
