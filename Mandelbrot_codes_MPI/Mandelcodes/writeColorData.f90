module writeColorData
  use parameter_reader
  use createRGB
  implicit none

contains

  subroutine save_colorData(colorMatrix)
    implicit none

    real, dimension(:,:,:), allocatable :: colorMatrix
    character(len=50) :: filename1,filename2,filename3
    integer :: i

    filename1 = 'red_Data.dat'
    filename2 = 'green_Data.dat'
    filename3 = 'blue_Data.dat'

    open(40,file=filename1)
    open(41,file=filename2)
    open(42,file=filename3)
    do i = 1,pixel_height
      write(40,*) real(colorMatrix(i,:,1))
      write(41,*) real(colorMatrix(i,:,2))
      write(42,*) real(colorMatrix(i,:,3))
    end do
    close(40)
    close(41)
    close(42)

  end subroutine save_colorData

end module writeColorData
