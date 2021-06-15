OBJECTS = Mandelbrot_Driver.o param_file_reader.o parameter_reader.o createArray.o \
                                        Mandel_funcs.o createMandel.o createRGB.o writeColorData.o

MODULES = param_file_reader.mod parameter_reader.mod createArray.mod \
                                        Mandel_funcs.mod createMandel.mod createRGB.mod writeColorData.mod

.PHONY: clean

brot.exe: $(MODULES) $(OBJECTS)
        mpif90 $(OBJECTS) -o brot.exe

%.o: %.f90
        mpif90 -c -fdefault-real-8 -fdefault-double-8 $<

%.mod: %.f90
        mpif90 -Wall -g -c -fdefault-real-8 -fdefault-double-8 $<

clean:
        rm *exe *o *mod *dat *out *err
