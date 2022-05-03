(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using SIKER
push!(Base.modules_warned_for, Base.PkgId(SIKER))
SIKER.main()
