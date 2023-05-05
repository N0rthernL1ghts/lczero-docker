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
cpuct={{ getenv "LCZERO_CPUCT" "3.0" }}
cpuct-base={{ getenv "LCZERO_CPUCT_BASE" "19652.00" }}
cpuct-factor={{ getenv "LCZERO_CPUCT_FACTOR" "2.00" }}
temperature={{ getenv "LCZERO_TEMPERATURE" "0" }}
tempdecay-moves={{ getenv "LCZERO_TEMPDECAY_MOVES" "0" }}
temp-cutoff-move={{ getenv "LCZERO_TEMP_CUTOFF_MOVE" "0" }}
temp-endgame={{ getenv "LCZERO_TEMP_ENDGAME" "0" }}
temp-value-cutoff={{ getenv "LCZERO_TEMP_VALUE_CUTOFF" "100.00" }}
temp-visit-offset={{ getenv "LCZERO_TEMP_VISIT_OFFSET" "0.00" }}
verbose-move-stats={{ getenv "LCZERO_VERBOSE_MOVE_STATS" "true" }}
smart-pruning-factor={{ getenv "LCZERO_SMART_PRUNING_FACTOR" "1.33" }}
fpu-strategy={{ getenv "LCZERO_FPU_STRATEGY" "reduction" }}
fpu-value={{ getenv "LCZERO_FPU_VALUE" "-1.00" }}
cache-history-length={{ getenv "LCZERO_CACHE_HISTORY_LENGTH" "0" }}
policy-softmax-temp={{ getenv "LCZERO_POLICY_SOFTMAX_TEMP" "2.20" }}
max-collision-events={{ getenv "LCZERO_MAX_COLLISION_EVENTS" "32" }}
max-collision-visits={{ getenv "LCZERO_MAX_COLLISION_VISITS" "9999" }}
out-of-order-eval={{ getenv "LCZERO_OUT_OF_ORDER_EVAL" "true" }}
syzygy-fast-play={{ getenv "LCZERO_SYZYGY_FAST_PLAY" "true" }}
multipv={{ getenv "LCZERO_MULTIPV" "1" }}
score-type={{ getenv "LCZERO_SCORE_TYPE" "centipawn" }}
history-fill={{ getenv "LCZERO_HISTORY_FILL" "fen_only" }}
kldgain-average-interval={{ getenv "LCZERO_KLDGAIN_AVERAGE_INTERVAL" "100" }}
minimum-kldgain-per-node={{ getenv "LCZERO_MINIMUM_KLDGAIN_PER_NODE" "0.00" }}

# Engine options
# See: https://lczero.org/dev/wiki/lc0-options/#engine-options
move-overhead={{ getenv "LCZERO_MOVE_OVERHEAD" "2000" }}
ramlimit-mb={{ getenv "LCZERO_RAM_LIMIT_MB" "512" }}
logfile=/lczero/logs/lczero.log

{{- $useSyzygyTables := getenv "LCZERO_USE_SYZYGY_TABLES" -}}
{{- if eq $useSyzygyTables "true" -}}
{{"\n"}}
syzygy-paths={{ getenv "LCZERO_SYZYGY_PATHS" "/lczero/resources/syzygy-tables" }}
{{"\n"}}
{{- end -}}