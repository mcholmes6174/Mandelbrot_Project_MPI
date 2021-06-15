module param_file_reader
  implicit none
  integer, parameter :: fileLen=50
  integer, parameter :: max_string_length=80

contains

  subroutine read_initFileReal(fileName,varName,varValue)

    implicit none
    character(len=*),intent(IN) :: fileName,varName
    real, intent(OUT) :: varValue

    integer :: i,openStatus,inputStatus
    real :: simInitVars
    character(len=max_string_length) :: simCharVars
    integer :: pos1,pos2

    open(unit = 10, file=fileName, status='old',IOSTAT=openStatus,FORM='FORMATTED',ACTION='READ')

    do i=1,fileLen
       read(10, FMT = 100, IOSTAT=inputStatus) simCharVars
       pos1 = index(simCharVars,varName)
       pos2 = pos1+len_trim(varName)
       if (pos2 > len_trim(varName)) then
          read(simCharVars(pos2+1:),*,end=600)simInitVars
          varValue = simInitVars
       endif
    end do

    600 close(10)

  100 FORMAT(A, 1X, F3.1)

  end subroutine read_initFileReal

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

subroutine read_initFileInt(fileName,varName,varValue)

  implicit none
  character(len=*),intent(IN) :: fileName,varName
  integer, intent(OUT) :: varValue

  integer :: i,openStatus,inputStatus
  integer :: simInitVars
  character(len=max_string_length) :: simCharVars
  integer :: pos1,pos2

  open(unit = 11, file=fileName, status='old',IOSTAT=openStatus,FORM='FORMATTED',ACTION='READ')

  do i=1,fileLen
     read(11, FMT = 101, IOSTAT=inputStatus) simCharVars
     pos1 = index(simCharVars,varName)
     pos2 = pos1+len_trim(varName)
     if (pos2 > len_trim(varName)) then
        read(simCharVars(pos2+1:),*,end=600)simInitVars
        varValue = simInitVars
     endif
  end do

  600 close(11)

101 FORMAT(A, 1X, I5)

end subroutine read_initFileInt


end module param_file_reader
