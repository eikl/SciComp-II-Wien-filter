# The name of the executable file that will be generated
TARGET = wienFilter

# The Fortran source files for the project
SOURCES = constants.f90 getData.f90 writeToFile.f90 moveParticle.f90 main.f90

# The Fortran compiler to use
FC = gfortran

# Compiler flags
FFLAGS = -Ofast

# The list of object files that will be generated from the source files
OBJECTS = $(SOURCES:.f90=.o)

# The default rule, which is used when you type "make" without any arguments
all: $(TARGET)

# This rule tells make how to build the executable file from the object files
# also remove the executable from ../run if it is there, so that we can move
# the new executable there
$(TARGET): $(OBJECTS)
	$(FC) $(FFLAGS) $^ -o $@
	rm -f ../run/$@
	mv $@ ../run

# This rule tells make how to build an object file from a source file
%.o: %.f90
	$(FC) $(FFLAGS) -c $< -o $@

# This rule tells make how to clean up the project directory
clean:
	rm -f $(OBJECTS)
