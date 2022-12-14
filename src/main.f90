program main
use move
use myData
use constants
use writeToFile
implicit none 

real(kind=(rk)) :: time = 5   !max time in seconds after which the program goes to the next particle (avoid infinite loops) 
real(kind=(rk)) :: pos(3)=0
integer, allocatable :: gotThrough(:) !indexes of particles that got through


call getData()
allocate(gotThrough(size(particle_array)))
call initFile("finaldata.dat")
!todo: remove hardcoded edges for the filter. these could be input from the data file
do while (len/=0)
    !write the box dimensions to the first line of the file
    open(1,file=trim(particle_array(len)%index)//".xyz")
    write(1,*) box
    do while (time>0)
        !print*, electricField, magneticField
        pos=newPosition(len,dt)
        if (pos(1)>box(1) .and. pos(2)<1e-5 .and. pos(2)>-1e-5 .and. pos(3)<1e-5 .and. pos(3)>-1e-5) then    !this happens if the particle goes through a small hole at the end of the filter (10um)
            print*,"particle number",len,"got through"
            gotThrough(len)=len
            exit
        end if
        if (pos(2)<-box(2) .or. pos(2)>box(2) .or. pos(3)<-box(3) .or. pos(3)>box(3)) then                  !this happens if the particle hits a wall
            print*, "particle number",len,"hit a wall"
            gotThrough(len)=0
            exit
        end if
        if (pos(1)>box(1) .and. ((pos(2)>1e-5 .or. pos(2)<-1e-5) .or.( pos(3)>1e-5 .or. pos(3)<-1e-5))) then ! this happens if the particle doesn't go through the small hole at the end of the filter
            print*,"particle number", len, "hit the end wall"   ! i.e. the particles speed is too far from E/B (hole size 10um)
            gotThrough(len)=0
            exit                                       
        end if
        if (time<0) then
            exit
        end if
        call writeArray(pos,trim(particle_array(len)%index)//".xyz")
        !print*, dt                                                       !write the position to file if the particle hasn't hit a wall and go to the next timestep
        time=time-dt
        !print*, time
    end do
len=len-1
end do
call particleData(gotThrough,"finaldata.dat")
!close(1)
if (ios==0)then
   call execute_command_line("./plot.sh") 
end if                                                                     !plot with python
end program