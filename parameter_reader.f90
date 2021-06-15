module parameter_reader
  use param_file_reader
  implicit none

  real, save    :: x_min, x_max, y_min, y_max
  integer, save :: pixel_width, pixel_height, max_esc_time

contains

  subroutine read_parameters()
    implicit none

    call read_initFileReal('param.init','x_min',x_min)
    call read_initFileReal('param.init','x_max',x_max)
    call read_initFileReal('param.init','y_min',y_min)
    call read_initFileReal('param.init','y_max',y_max)

    call read_initFileInt('param.init','pixel_width',pixel_width)
    call read_initFileInt('param.init','pixel_height',pixel_height)

    call read_initFileInt('param.init','max_esc_time',max_esc_time)

  end subroutine read_parameters

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine save_parameters()
    implicit none

    character(len=50) :: filename

    filename = 'info4Python.dat'

    open(90,file=filename)
    write(90,*) x_min
    write(90,*) x_max
    write(90,*) y_min
    write(90,*) y_max
    write(90,*) pixel_width
    write(90,*) pixel_height
    write(90,*) max_esc_time
    close(90)

  end subroutine save_parameters

end module parameter_reader
