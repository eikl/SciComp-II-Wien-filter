**Execution instructions and example inputs and outputs**

All following units used in the program are base SI units.


**Command line arguments**

The program reads command line arguments in the following format

./wienFilter <input filename> <timeStep(s)> <EField_x> <Efield_y> <Efield_z> <Bfield_x> <Bfield_y> <Bfield_z>

The numeric command line arguments can be input in scientific format. (i.e timestep = 1e-10)

The sign convention is as follows: (in reference to the picture in the report)
Positive x is to the right, negative is to the left.
Positive y is up, negative is down.
Positive z is away from the user, negative is towards.

**Input data file**

The program reads a file specified in the first command line arguments. It should be formatted as follows:

<Number of particles>
<box length in x dimension> <box length in y dimension> <box length in z dimension>
<Particle number> <v_x> <v_y> <v_z> <mass> <charge>
etc...

Where "box" refers to the wien filter itself and its dimensions.
examples of input data files can be found in the run folder.

**Output data file format**

The program outputs data in the following format:

<box length in x dimension> <box length in y dimension> <box length in z dimension>
<Particle x position> <Particle y position> <Particle z position>
etc...

**Output file that contains data about the particles that got through the filter**

The program alse outputs the following file: finaldata.dat
this file contanins: (in this order)

<Index of the particle> <Final velocity (vector)> <Final position (vector)> <mass> <charge>

**Example parameters**

**Electrons**

To simulate the electron trajectories discussed in the report, the following command line arguments and input files should be used:

./wienFilter electrons.dat 1e-10 0 250 0 0 0 0.00013

The program should automatically plot the data with Python. A reference image can be found in the report.

**Circle**

To simulate a test of the numerical integration where we forget the electric field, so that the particle's trajectory is a circle, the following command is issued:

./wienFilter circle.dat 1e-5 0 0 0 0 0 10

The expected trajectory for the particle is a circle. If the timestep is too small, the particle's trajectory will be a spiral due to the integration error.
We can demonstrate this with the command 

./wienFilter circle.dat 1e-2 0 0 0 0 0 10

**Changing signs**

To simulate the effect of changing the sign of the charge of a particle that doesn't go through the filter, use the command

./wienFilter signs.dat 1e-6 0 10 0 0 0 10

From the plot of the trajectories, we can see that changing the sign of the charge "flips" the particles trajectory.

**Issues**

If running the plot.sh script from the Fortran code doesn't work, you can just manually run the script from the terminal (it is in /run/output_data)

If your selected timestep is too small, the Python plotter will throw an error. E.g if the particle hits the wall "instantly" (in 1 time step), Python cannot plot this.
