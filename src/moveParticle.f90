module move
use myData
use constants
implicit none
contains
function newPosition(particleIndex,timeStep)
    !f_x=q(e_x+v_yb_z-v_zb_y)
    !F=ma
    !a=F/m
    !v/dt=F/m
    !V=f/m*dt
    !first calculate the forces
    integer :: particleIndex
    real(kind=(rk))    :: timeStep
    real(kind=(rk)) :: f(3)
    real(kind=(rk)) :: a(3)
    real(kind=(rk)) :: v(3)
    real(kind=(rk)),dimension(3) :: newPosition

    !calculate the forces on the particle
    v = particle_array(particleIndex)%velocity
    f = particle_array(particleIndex)%chrg*(electricField+cross(v,magneticField))
    a = f/particle_array(particleIndex)%mass
    !print*, "f_z", f(3)
    !print*, "f_y", f(2)
    !calculate the new speed
    particle_array(particleIndex)%velocity = particle_array(particleIndex)%velocity + a*timeStep
    !print*, particle_array(particleIndex)%velocity
    !calculate the new position
    particle_array(particleIndex)%position=particle_array(particleIndex)%position + v * timeStep
    newPosition = particle_array(particleIndex)%position
    !print*, newPosition
    !print*, a
    return

end function

FUNCTION cross(a, b)
  real(kind=rk), DIMENSION(3) :: cross
  real(kind=rk), DIMENSION(3), INTENT(IN) :: a, b

  cross(1) = a(2) * b(3) - a(3) * b(2)
  cross(2) = a(3) * b(1) - a(1) * b(3)
  cross(3) = a(1) * b(2) - a(2) * b(1)
END FUNCTION cross

end module