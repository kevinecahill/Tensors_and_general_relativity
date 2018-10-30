program t2x100ky
  ! x is a/a0, for the radiation/matter eras
  implicit none
  integer(kind=4)::i
  integer(kind=4),parameter::nx=10**9
  real(kind=8)::x,dx,integral
  real(kind=8),dimension(1:nx/10**3)::t
  real(kind=8),parameter::TH=14.461e9 ! TH = 1/H_0
  real(kind=8),parameter::OmL=0.6889,Omm=0.3111,Omr=9.082367e-5
  real(kind=8),parameter::OmK=0.0007,half = 0.5d0
  real(kind=8),parameter::rhoc0 = 8.59897D-27 ! kg/m^3
  real(kind=8),parameter::zero=0.0d0,one=1.0d0,tenth=0.1d0
  integral = zero
  dx = one/nx; x = half*dx
  do i = 1, nx/10**3
     integral = integral + dx*TH/sqrt(OmL*x**2 + OmK + Omm/x + Omr/x**2)
     t(i) = integral  ! time in years to get to a/a_0 = x
     x = x + dx
  end do
  open(7,file='newx2tRM.dat')
  x = half*dx
  do i = 1, nx/10**3
     !                        a/a_0                            t          
     write(7,*) (half + i - 1)*dx, t(i), one/((i-half)*dx) - one
     x = x + dx
  end do
  close(7)
  open(7,file='newx2trhom.dat')
  do i = 1, nx/10**3
     !          rho_m                             t        
     write(7,*) rhoc0*Omm/((half + i - 1)*dx)**3, t(i)
  end do
  close(7)
  open(7,file='newx2trhor.dat')
  do i = 1, nx/10**3
     !          rho_r                             t        
     write(7,*) rhoc0*Omr/((half + i - 1)*dx)**4, t(i)
  end do
  close(7)
end program t2x100ky
