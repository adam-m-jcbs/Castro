# ------------------  INPUTS TO MAIN PROGRAM  -------------------
stop_time = 8.0                 

# PROBLEM SIZE & GEOMETRY
geometry.is_periodic = 1   1
geometry.coord_sys   = 0        # 0 => cart, 1 => RZ  2=>spherical
geometry.prob_lo     = 0.0 0.0
geometry.prob_hi     = 1.0 2.0
castro.center        = 0.5 1.0

amr.n_cell           = 256 512
amr.max_level        = 0        # maximum level number allowed; base level is 0

amr.max_grid_size    = 64

amr.ref_ratio        = 2 2 2 2  # refinement ratio

# >>>>>>>>>>>>>  BC FLAGS <<<<<<<<<<<<<<<<
# 0 = Interior           3 = Symmetry
# 1 = Inflow             4 = SlipWall
# 2 = Outflow            5 = NoSlipWall
# >>>>>>>>>>>>>  BC FLAGS <<<<<<<<<<<<<<<<
castro.lo_bc       =  0   0
castro.hi_bc       =  0   0

# WHICH PHYSICS
castro.do_hydro = 1
castro.ppm_type = 1
castro.allow_negative_energy = 0
castro.small_temp = 1.e-4
castro.small_dens = 1.e-4

# TIME STEP CONTROL
castro.cfl            = 0.8     # cfl number for hyperbolic system
castro.init_shrink    = 0.1     # scale back initial timestep
castro.change_max     = 1.1     # scale back initial timestep
castro.dt_cutoff      = 5.e-20  # level 0 timestep below which we halt

# DIAGNOSTICS & VERBOSITY
castro.sum_interval   = 1       # timesteps between computing mass
castro.v              = 1       # verbosity in Castro.cpp
amr.v                 = 1       # verbosity in Amr.cpp
amr.grid_log          = grid_diag.out   # name of grid logging file

# REFINEMENT / REGRIDDING 
amr.ref_ratio       = 2 2 2 2   # refinement ratio
amr.regrid_int      = 2 2 2 2   # how often to regrid
amr.blocking_factor = 4         # block factor in grid generation
amr.n_error_buf     = 2 2 2 2   # number of buffer cells in error est

# CHECKPOINT FILES
amr.checkpoint_files_output = 1
amr.check_file      = chk       # root name of checkpoint file
amr.check_per       = 1.0       # number of timesteps between checkpoints

# PLOTFILES
amr.plot_files_output = 1
amr.plot_file       = plt       # root name of plotfile
amr.plot_per        = 0.1       # time between plotfiles

amr.plot_vars = ALL 
amr.derive_plot_vars = NONE

# PROBIN FILENAME
amr.probin_file = probin.p4
