module writeToFile
use constants
use myData
implicit none


contains 

!this subroutine writes an array to a file
subroutine writeArray(array,filename)  
    implicit none
    real(kind=(rk)),dimension(3), intent(in) :: array
    character(len=10), intent(in) :: filename
    integer :: ios
    open(1,file=trim(filename),iostat=ios)
    if (ios==0) then
        write(1,*) array
    else
        print*, "error writing to output"
        stop
    endif
end subroutine

!this subroutine initializes the final data file:

subroutine initFile(filename)
    implicit none
    character(len=50),intent(in) :: filename
    open(2,file=trim(filename),iostat=ios)
    write(2,"(*(A,22X))") "Particle number", "Final velocity", "Final pos", "mass", "charge"
end subroutine
!this subroutine writes a particles data to a file with formatting:

subroutine particleData(passedParticles, filename)
    implicit none
    integer :: ios,i
    character(len=50),intent(in) :: filename
    integer, intent(in)          :: passedParticles(size(particle_array))
    open(2,file=trim(filename),iostat=ios)
    if (ios==0) then
        do i=1,size(passedParticles)
            if (passedParticles(i)/=0) then
                write(2,"((I5,13X),(A), 3(2X,ES10.3),(A), 3(2X,ES10.3),(A), (5X,ES10.3),(A), (10X,ES10.3) )") passedParticles(i)&  !:-D
                ,"|",particle_array(i)%velocity,"  |",&
                 particle_array(i)%position,"  |", particle_array(i)%mass,"    |", particle_array(i)%chrg
            else
                continue
            end if
        end do
    end if
end subroutine

end module