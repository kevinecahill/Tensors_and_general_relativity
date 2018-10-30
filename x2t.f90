program x2t
  ! x is a/a0
  implicit none
  integer(kind=8)::i
  integer(kind=8),parameter::nx=10**8
  real(kind=8)::x,dx,integral
  real(kind=8),dimension(1:nx)::tPC
  real(kind=8),parameter::TH=14.461e9 ! TH = 1/H_0
  real(kind=8),parameter::OmL=0.6889,Omm=0.3111,Omr=9.082367e-5
  real(kind=8),parameter::OmK=0.0007,half = 0.5d0
  real(kind=8),parameter::rhoc0 = 8.59897D-27 ! kg/m^3
  real(kind=8),parameter::zero=0.0d0,one=1.0d0,tenth=0.1d0
  integral = zero
  dx = one/nx; x = half*dx
  do i = 1, nx
     integral = integral + dx/sqrt(OmL*x**2 + OmK + Omm/x + Omr/x**2)
     tPC(i) = integral*TH ! time in years to get to a/a_0 = x
     x = x + dx
  end do
   open(7,file='x2t.dat')
   do i = 1, nx, 1000
  !                  a/a_0                  t         z(t)                               T_r(t)
     write(7,*) (half + i - 1)*dx, tPC(i), one/((i-half)*dx) - one, 2.7255/((i+1)*dx)
  end do
  close(7)
end program x2t
