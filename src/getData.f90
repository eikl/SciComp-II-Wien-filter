
module myData
use constants
implicit none
!datatype for particles
type :: particle
    character(len=10) :: index
    real(kind=rk)      :: velocity(3)
    real(kind=rk)      :: position(3)=0
    real(kind=rk)      :: prevAcceleration(3)
    real(kind=(rk))    :: mass
    real(kind=(rk))    :: chrg
end type


integer :: len,ios,nlines
character(len=100) :: filename,arg

integer,private::i
real(kind=rk):: electricField(3), magneticField(3)
real(kind=(rk)) :: dt,temp
real(kind=(rk)) :: box(3)=0

type(particle),allocatable :: particle_array(:)
contains

subroutine getData()
implicit none

!get the filename from command line argument
call get_command_argument(1,filename,status=ios)
if (ios==0) then                                                     
    open(1,file=filename,iostat=ios)
else
    print*, "Error getting command argument"
    stop
end if

!read length of data (ammount of particles), which is stored in the first line of input data file.
if (ios==0) then
    read(1,*,iostat=ios) len
else
    print*, "error opening file", trim(filename)
    stop
end if
if (ios==0) then
    allocate(particle_array(len))
else
    print*, "error reading file ", trim(filename)
    stop
end if
!read the box dimensions from the second line of the file
read(1,*) box(1), box(2), box(3)
!particle starts at (0,0,0), so y and z box dimensions must be halved
box(2)=box(2)/2
box(3)=box(3)/2

!check if the file has the proper ammount of lines:
nlines = 0
open(5,file=filename)
do
  read(5,*,iostat=ios)
  if (ios/=0) exit
  nlines = nlines + 1
end do
close(5)
!print*, nlines
!stop code if data doesn't contain the ammount of particles specified in the first line of particle data file
if (nlines/=len+2) then
    print*, "imporper ammount of lines in ", trim(filename)
    stop
end if

!on lines after that, we read the rest of the input data in the predetermined order.
do i=1,len
    read(1,*) particle_array(i)%index, particle_array(i)%velocity(1), particle_array(i)%velocity(2),&
    particle_array(i)%velocity(3), particle_array(i)%mass, particle_array(i)%chrg
end do
!get the rest of the parameters for the simulation as command line arguments
call get_command_argument(2,arg,status=ios)

if (ios==0) then
    read(arg,*,iostat=ios) temp
    if (ios==0) then
        dt=temp
        !print*, dt
    else
        print*, "incorrect type in argument 2"
        stop
    endif
else
    print*, "error reading command argument 2"
    stop
endif

call get_command_argument(3,arg,status=ios)
if (ios==0) then
    read(arg,*) temp
    if (ios==0) then
        electricField(1)=temp
    else
        print*, "incorrect type in argument 3"
        stop
    endif
else
    print*, "error reading command argument 3"
    stop
endif

call get_command_argument(4,arg,status=ios)
if (ios==0) then
    read(arg,*) temp
    if (ios==0) then
        electricField(2)=temp
    else
        print*, "incorrect type in argument 4"
        stop
    endif
else
    print*, "error reading command argument 4"
    stop
end if

call get_command_argument(5,arg,status=ios)
if (ios==0) then
read(arg,*) temp
    if (ios==0) then
        electricField(3)=temp
    else
        print*, "incorrect type in argument 5"
        stop
    endif
else
    print*, "error reading command argument 5"  
    stop
end if

call get_command_argument(6,arg,status=ios)
if (ios==0) then
read(arg,"(F5.3)") temp
    if (ios==0) then
        magneticField(1)=temp
    else
        print*, "incorrect type in argument 6"
        stop
    endif
else
    print*, "error reading command argument 6"
    stop
end if

call get_command_argument(7,arg,status=ios)
if (ios==0) then
read(arg,"(F5.3)") temp
    if (ios==0) then
        magneticField(2)=temp
    else
        print*, "incorrect type in argument 7"
        stop
    endif
else
    print*, "error reading command argument 7"
    stop
end if

call get_command_argument(8,arg,status=ios)
if (ios==0) then
read(arg,*) temp
    if (ios==0) then
        magneticField(3)=temp
    else
        print*, "incorrect type in argument 8"
        stop
    endif
else
    print*, "error reading command argument 8"  
    stop
end if
end subroutine
end module