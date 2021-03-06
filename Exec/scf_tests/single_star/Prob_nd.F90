subroutine amrex_probinit(init, name, namlen, problo, probhi) bind(c)

  use amrex_constants_module
  use probdata_module
  use amrex_constants_module
  use castro_error_module
  use fundamental_constants_module
  use amrex_fort_module, only : rt => amrex_real

  implicit none

  integer, intent(in) :: init, namlen
  integer, intent(in) :: name(namlen)
  real(rt), intent(in) :: problo(3), probhi(3)

  call probdata_init(name, namlen)

end subroutine amrex_probinit

subroutine ca_initdata(level, time, lo, hi, nscal, &
                       state, state_lo, state_hi, &
                       dx, xlo, xhi)

  use amrex_constants_module, only: ZERO, HALF
  use amrex_fort_module, only : rt => amrex_real
  use probdata_module, only: radius, density, ambient_dens
  use meth_params_module, only : NVAR, URHO, UMX, UMY, UMZ, UTEMP, &
                                 UEDEN, UEINT, UFS, UFA
  use network, only : nspec
  use prob_params_module, only: problo, probhi, center
  use eos_type_module, only: eos_input_rt, eos_t
  use eos_module, only: eos

  implicit none

  integer :: level, nscal
  integer :: lo(3), hi(3)
  integer :: state_lo(3), state_hi(3)
  real(rt) :: xlo(3), xhi(3), time, dx(3)
  real(rt) :: state(state_lo(1):state_hi(1),state_lo(2):state_hi(2),state_lo(3):state_hi(3),NVAR)

  real(rt) :: xx, yy, zz

  integer :: i, j, k

  type (eos_t) :: eos_state

  !$OMP PARALLEL DO PRIVATE(i, j, k, xx, yy, zz, eos_state)
  do k = lo(3), hi(3)
     zz = problo(3) + dx(3) * (dble(k)+HALF) - center(3)

     do j = lo(2), hi(2)
        yy = problo(2) + dx(2) * (dble(j)+HALF) - center(2)

        do i = lo(1), hi(1)
           xx = problo(1) + dx(1) * (dble(i)+HALF) - center(1)

           ! Establish the initial guess: a uniform density sphere

           if ((xx**2 + yy**2 + zz**2)**0.5 < radius) then
              state(i,j,k,URHO) = density
           else
              state(i,j,k,URHO) = ambient_dens
           endif

           state(i,j,k,UMX:UMZ) = ZERO
           state(i,j,k,UTEMP) = 1.0e7_rt
           state(i,j,k,UFS:UFS+nspec-1) = state(i,j,k,URHO) / nspec

           eos_state % rho = state(i,j,k,URHO)
           eos_state % T = state(i,j,k,UTEMP)
           eos_state % xn = state(i,j,k,UFS:UFS+nspec-1) / state(i,j,k,URHO)

           call eos(eos_input_rt, eos_state)

           state(i,j,k,UEINT) = eos_state % e * state(i,j,k,URHO)
           state(i,j,k,UEDEN) = state(i,j,k,UEINT) + HALF * sum(state(i,j,k,UMX:UMZ)**2) / state(i,j,k,URHO)

        enddo
     enddo
  enddo
  !$OMP END PARALLEL DO

end subroutine ca_initdata
