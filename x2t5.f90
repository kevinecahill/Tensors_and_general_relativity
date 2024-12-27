program x2t5
  ! x is a/a0 
  ! only ordinary matter and radiation are counted
  implicit none
  integer(kind=4)::i
  integer(kind=4),parameter::nx=2.0*10**8
  real(kind=8)::x,dx,integral
  real(kind=8),dimension(1:nx)::t
  real(kind=8),parameter::TH=14.435e9 ! TH = 1/H_0
  real(kind=8),parameter::OmL=0.0,Omm=0.04897324,Omr=9.0606e-5
  real(kind=8),parameter::OmK=0.0008,half = 0.5d0
  real(kind=8),parameter::zero=0.0d0,one=1.0d0,tenth=0.1d0
  integral = zero
  dx = one/nx; x = half*dx
  do i = 1, nx
     integral = integral + dx*TH/sqrt(OmL*x**2 + OmK + Omm/x + Omr/x**2)
     t(i) = integral ! time in years to get to a/a_0 = x
     x = x + dx
  end do
   open(7,file='x2t5.dat')
   do i = 1, nx, 1000
  !                    a/a_0     t      z(t)                              T_r(t)
     write(7,*) (half + i - 1)*dx, t(i), one/((i-half)*dx) - one, 2.7255/((i+1)*dx)
  end do
  close(7)
end program x2t5
