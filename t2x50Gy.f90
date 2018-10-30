program newx2tMV
  ! x is a/a0, for the matter/vacuum era, uses Planck's 2018 values
  implicit none
  integer(kind=4)::i
  integer(kind=4),parameter::nx=10**7,nexp=5
  real(kind=8)::x,dx,integral
  real(kind=8),dimension(1:nexp*nx)::t
  real(kind=8),parameter::TH=1.4461E10 ! TH = 1/H_0
  real(kind=8),parameter::OmL=0.6889,Omm=0.3111,Omr=9.082367e-5
  real(kind=8),parameter::OmK=0.0007,half = 0.5d0
  real(kind=8),parameter::rhoc0 = 8.59897D-27 ! kg/m^3
  real(kind=8),parameter::zero=0.0d0,one=1.0d0,tenth=0.1d0,two=2.0d0
  integral = zero
  dx = two/nx; x = half*dx
  do i = 1, nexp*nx
     integral = integral + dx*TH/sqrt(OmL*x**2 + OmK + Omm/x + Omr/x**2)
     t(i) = integral  ! time in years to get to a/a_0 = x
     x = x + dx
  end do
  open(7,file='newx2tMV.dat')
  x = half*dx
  do i = 1, nexp*nx, 100
     !               a/a_0       t           z(t)                            T_r
     write(7,'(5(E15.8,1x))') (half + i - 1)*dx, t(i) , one/((i-half)*dx) - one, &
          2.7255/((i+1)*dx), TH/sqrt(OmL*x**2 + OmK + Omm/x + Omr/x**2)
     x = x + dx
  end do
  close(7)
  open(7,file='newx2trhoMv.dat')
  do i = 1, nexp*nx, 100
     !               rho                                                  t        
     write(7,*) rhoc0*Omm/((half + i - 1)*dx)**3, t(i)
  end do
  close(7)
  open(7,file='newx2trhoVm.dat')
  do i = 1, nexp*nx, 100
     !               a/a_0                                     t        
     write(7,*) rhoc0*OmL, t(i)
  end do
  close(7)
end program newx2tMV
