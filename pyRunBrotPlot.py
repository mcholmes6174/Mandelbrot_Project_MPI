###################################################################
# Mandelbrot Set Plotting
# Written by Matthew Holmes
# This Python program will clean, compile, and run the Fortran code
# In order to run this program, the user should type "iPython"
# in the terminal, and then "run pyRunBrotPlot.py"
###################################################################

# import Python operating system module and others
import os
import numpy as np
from PIL import Image

###################################################################

def unixMake():
    os.chdir('../Mandelbrot_codes')
    os.system('make clean')
    os.system('make')
    os.chdir('../PyViz')

###################################################################

def runMandel():
    os.chdir('../Mandelbrot_codes')
    os.system('./Mandelbrot.exe')
    os.chdir('../PyViz')

###################################################################

def makePlot():
    # Get parameters and RGB data
    os.chdir('../Mandelbrot_codes')
    x_min, x_max, y_min, y_max, pixel_width, \
    pixel_height, max_esc_time = np.loadtxt('info4Python.dat')
    redArray   = np.genfromtxt('red_Data.dat',dtype=np.uint8)
    greenArray = np.genfromtxt('green_Data.dat',dtype=np.uint8)
    blueArray  = np.genfromtxt('blue_Data.dat',dtype=np.uint8)
    os.chdir('../PyViz')

    RGB_Array = np.zeros((int(pixel_height),int(pixel_width),3),dtype=np.uint8)
    RGB_Array[:,:,0] = redArray
    RGB_Array[:,:,1] = greenArray
    RGB_Array[:,:,2] = blueArray

    img = Image.fromarray(RGB_Array)
    img.save('Mandelbrot.png')

    print(' Image Created!')
    print(' ==============================')

###################################################################

if __name__ == '__main__':
    unixMake()
    runMandel()
    makePlot()
