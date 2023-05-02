# See: https://lczero.org/dev/wiki/lc0-options/
##################################################

# Lc0 options
# See: https://lczero.org/dev/wiki/lc0-options/#lc0-options
backend={{ getenv "LCZERO_BACKEND" "multiplexing" }}
backend-opts={{ getenv "LCZERO_BACKEND_OPTS" "" }}
threads={{ getenv "LCZERO_THREADS" "2" }}
nncache={{ getenv "LCZERO_NNCACHE" "200000" }}
weights=/lczero/resources/network

# Search options
# See: https://lczero.org/dev/wiki/lc0-options/#search-options
minibatch-size={{ getenv "LCZERO_MINIBATCH_SIZE" "256" }}
max-prefetch={{ getenv "LCZERO_MAX_PREFETCH" "32" }}
fpu-strategy={{ getenv "LCZERO_FPU_STRATEGY" "reduction" }}
verbose-move-stats={{ getenv "LCZERO_VERBOSE_MOVE_STATS" "true" }}
multipv={{ getenv "LCZERO_MULTIPV" "1" }}

# Engine options
# See: https://lczero.org/dev/wiki/lc0-options/#engine-options
slowmover={{ getenv "LCZERO_SLOWMOVER" "1.0" }}
move-overhead={{ getenv "LCZERO_MOVE_OVERHEAD" "2000" }}
ramlimit-mb={{ getenv "LCZERO_RAM_LIMIT_MB" "512" }}
syzygy-paths=/lczero/resources/syzygy-tables
logfile=/lczero/logs/lczero.log