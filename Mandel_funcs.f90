module Mandel_funcs
  use parameter_reader
  implicit none

contains

  subroutine update_Trajectory(c,z,z_out)
    implicit none

    complex, intent(IN)  :: c, z
    complex, intent(OUT) :: z_out

    z_out = z**2 + c

  end subroutine update_Trajectory

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine escTime(c,time2esc)
    implicit none

    complex, intent(IN) :: c
    real, intent(OUT)   :: time2esc

    integer :: k
    complex :: z_prev, z_next

    k = 0
    z_prev = cmplx(0.0)
    z_next = cmplx(0.0)

    do while (k < max_esc_time)
      k = k + 1
      call update_Trajectory(c, z_prev, z_next)
      z_prev = z_next
      if (cabs(z_next)>2) then
        ! if unstable and escapes, return k
        time2esc = real(k)
        exit
      end if
    end do

    ! if no escape, then return 0.0 to plot as black
    if (k .eq. max_esc_time) then
      time2esc = 0.0
    end if

  end subroutine escTime

end module Mandel_funcs
