# See: https://lczero.org/dev/wiki/lc0-options/
##################################################
backend={{ getenv "LCZERO_BACKEND" "multiplexing" }}
#backend-opts={{ getenv "LCZERO_BACKEND_OPTS" }}
#threads={{ getenv "LCZERO_THREADS" "2" }}
fpu-strategy={{ getenv "LCZERO_FPU_STRATEGY" "reduction" }}
ramlimit-mb={{ getenv "LCZERO_RAM_LIMIT_MB" "512" }}
multipv={{ getenv "LCZERO_MULTIPV" "1" }}
verbose-move-stats={{ getenv "LCZERO_VERBOSE_MOVE_STATS" "true" }}
move-overhead={{ getenv "LCZERO_MOVE_OVERHEAD" "2000" }}
weights=/lczero/resources/network
syzygy-paths=/lczero/resources/syzygy-tables
logfile=/lczero/logs/lczero.log

