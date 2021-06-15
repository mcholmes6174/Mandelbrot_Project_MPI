!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Mandelbrot Set Plotting Routine
! Written by Matthew Holmes
! 3/20/2021
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program Mandelbrot_Driver
  use mpi
  use parameter_reader
  use createArray
  use createMandel
  use createRGB
  use writeColorData
  implicit none

  real :: xChunk, xL, xR
  integer :: i, ierr, pID, numProc, cChunk, cL, cR, root=0
  integer, dimension(:),  allocatable :: RECVCOUNTS, DISPLS
  real, dimension(:,:,:), allocatable :: RGB

  call MPI_INIT(ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, pID, ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, numProc, ierr)

  call read_parameters()

  call save_parameters()

! PARTITION
  cChunk = nint(real(pixel_width/numProc)) ! size of column chunks
  xChunk = (x_max-x_min)/real(numProc) ! length of local x interval
  cL = 1 + pID*cChunk ! left column index
  xL = x_min + pID*xChunk ! left interval endpoint
  if (pID .eq. numProc - 1) then
    cR = pixel_width; xR = x_max ! right index = last (for p-1 processor)
  else
    cR = cL + cChunk - 1; xR = xL + xChunk ! right index for all others
  end if

  call create_pixelArray(cR-cL+1, xL, xR)

  call run_createMandel(cR-cL+1)

  call create_colorArray(cR-cL+1)

! GATHER
  if (pID .eq. root) then
    allocate(RECVCOUNTS(numProc)); RECVCOUNTS = pixel_height*cChunk
    RECVCOUNTS(numProc) = pixel_height*(pixel_width - (numProc-1)*cChunk)
    allocate(DISPLS(numProc)); DISPLS = 0
    do i = 2, numProc
      DISPLS(i) = (i-1)*pixel_height*cChunk
    end do
    allocate(RGB(pixel_height,pixel_width,3)); RGB = 0.0
  end if

  call MPI_GATHERV(R, size(R), MPI_DOUBLE, &
      & RGB(:,:,1), RECVCOUNTS, DISPLS, MPI_DOUBLE, root, MPI_COMM_WORLD, ierr)
  call MPI_GATHERV(G, size(G), MPI_DOUBLE, &
      & RGB(:,:,2), RECVCOUNTS, DISPLS, MPI_DOUBLE, root, MPI_COMM_WORLD, ierr)
  call MPI_GATHERV(B, size(B), MPI_DOUBLE, &
      & RGB(:,:,3), RECVCOUNTS, DISPLS, MPI_DOUBLE, root, MPI_COMM_WORLD, ierr)

  if (pID .eq. root) then
    call save_colorData(RGB)
  end if

  call MPI_FINALIZE(ierr)

end program Mandelbrot_Driver
