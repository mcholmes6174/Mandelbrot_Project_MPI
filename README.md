# Mandelbrot_Project_MPI
This code creates images of the Mandelbrot set. The source files are split into two subdirectories as follows:
  
  -> Mandelcodes
  
      
      -> 8 Fortran scripts
      
      -> 1 Makefile
      
      -> 1 parameter text file
      
  -> PyViz
  
      
      -> 1 Python script
    
The computation and data-generation is done using Fortran, while the image is created using Python.
There is a makefile used to compile all of the Fortran code. The param.init file contains seven parameters to be read-in by the Fortran script. If
the user wishes to alter the colors data generated by the Fortran code, they must edit the file createRGB.f90, and re-compile. After running the
Fortran executable brot.exe, the Python script may be run which will produce the image file within the PyViz directory.
