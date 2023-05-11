# See: https://lczero.org/dev/wiki/lc0-options/
# See: https://lczero.org/play/configuration/flags/
##################################################

# Lc0 options
# See: https://lczero.org/dev/wiki/lc0-options/#lc0-options

weights={{ getenv "LCZERO_WEIGHTS" "/lczero/resources/network" }}{{"\n"}}

# This option is enabled by default in this image
verbose-move-stats={{ getenv "LCZERO_VERBOSE_MOVE_STATS" "true" }}{{"\n"}}

{{- if getenv "LCZERO_BACKEND" -}}
{{"\n"}}backend={{ .Env.LCZERO_BACKEND }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_BACKEND_OPTS" -}}
{{"\n"}}backend-opts={{ .Env.LCZERO_BACKEND_OPTS }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_THREADS" -}}
{{"\n"}}threads={{ .Env.LCZERO_THREADS }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_NNCACHE" -}}
{{"\n"}}nncache={{ .Env.LCZERO_NNCACHE }}{{"\n"}}
{{- end -}}

# Search options
# See: https://lczero.org/dev/wiki/lc0-options/#search-options
{{- if getenv "LCZERO_MINIBATCH_SIZE" -}}
{{"\n"}}minibatch-size={{ .Env.LCZERO_MINIBATCH_SIZE }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_MAX_PREFETCH" -}}
{{"\n"}}max-prefetch={{ .Env.LCZERO_MAX_PREFETCH }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_CPUCT" -}}
{{"\n"}}cpuct={{ .Env.LCZERO_CPUCT }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_CPUCT_BASE" -}}
{{"\n"}}cpuct-base={{ .Env.LCZERO_CPUCT_BASE }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_CPUCT_FACTOR" -}}
{{"\n"}}cpuct-factor={{ .Env.LCZERO_CPUCT_FACTOR }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_TEMPERATURE" -}}
{{"\n"}}temperature={{ .Env.LCZERO_TEMPERATURE }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_TEMPDECAY_MOVES" -}}
{{"\n"}}tempdecay-moves={{ .Env.LCZERO_TEMPDECAY_MOVES }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_TEMP_CUTOFF_MOVE" -}}
{{"\n"}}temp-cutoff-move={{ .Env.LCZERO_TEMP_CUTOFF_MOVE }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_TEMP_ENDGAME" -}}
{{"\n"}}temp-endgame={{ .Env.LCZERO_TEMP_ENDGAME }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_TEMP_VALUE_CUTOFF" -}}
{{"\n"}}temp-value-cutoff={{ .Env.LCZERO_TEMP_VALUE_CUTOFF }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_TEMP_VISIT_OFFSET" -}}
{{"\n"}}temp-visit-offset={{ .Env.LCZERO_TEMP_VISIT_OFFSET }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_SMART_PRUNING_FACTOR" -}}
{{"\n"}}smart-pruning-factor={{ .Env.LCZERO_SMART_PRUNING_FACTOR }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_FPU_STRATEGY" -}}
{{"\n"}}fpu-strategy={{ .Env.LCZERO_FPU_STRATEGY }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_FPU_VALUE" -}}
{{"\n"}}fpu-value={{ .Env.LCZERO_FPU_VALUE }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_CACHE_HISTORY_LENGTH" -}}
{{"\n"}}cache-history-length={{ .Env.LCZERO_CACHE_HISTORY_LENGTH }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_POLICY_SOFTMAX_TEMP" -}}
{{"\n"}}policy-softmax-temp={{ .Env.LCZERO_POLICY_SOFTMAX_TEMP }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_MAX_COLLISION_EVENTS" -}}
{{"\n"}}max-collision-events={{ .Env.LCZERO_MAX_COLLISION_EVENTS }}{{"\n"}}
{{- end -}}


{{- if getenv "LCZERO_MAX_COLLISION_VISITS" -}}
{{"\n"}}max-collision-visits={{ .Env.LCZERO_MAX_COLLISION_VISITS }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_OUT_OF_ORDER_EVAL" -}}
{{"\n"}}out-of-order-eval={{ .Env.LCZERO_OUT_OF_ORDER_EVAL }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_SYZYGY_FAST_PLAY" -}}
{{"\n"}}syzygy-fast-play={{ .Env.LCZERO_SYZYGY_FAST_PLAY }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_MULTIPV" -}}
{{"\n"}}multipv={{ .Env.LCZERO_MULTIPV }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_SCORE_TYPE" -}}
{{"\n"}}score-type={{ .Env.LCZERO_SCORE_TYPE }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_HISTORY_FILL" -}}
{{"\n"}}history-fill={{ .Env.LCZERO_HISTORY_FILL }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_KLDGAIN_AVERAGE_INTERVAL" -}}
{{"\n"}}kldgain-average-interval={{ .Env.LCZERO_KLDGAIN_AVERAGE_INTERVAL }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_MINIMUM_KLDGAIN_PER_NODE" -}}
{{"\n"}}minimum-kldgain-per-node={{ .Env.LCZERO_MINIMUM_KLDGAIN_PER_NODE }}{{"\n"}}
{{- end -}}

# Engine options
# See: https://lczero.org/dev/wiki/lc0-options/#engine-options

# This option is enabled by default in this image
logfile=/lczero/logs/lczero.log

{{- if getenv "LCZERO_MOVE_OVERHEAD" -}}
{{"\n"}}move-overhead={{ .Env.LCZERO_MOVE_OVERHEAD }}{{"\n"}}
{{- end -}}

{{- if getenv "LCZERO_RAM_LIMIT_MB" -}}
{{"\n"}}ramlimit-mb={{ .Env.LCZERO_RAM_LIMIT_MB }}{{"\n"}}
{{- end -}}

{{- $useSyzygyTables := getenv "LCZERO_USE_SYZYGY_TABLES" -}}
{{- if eq $useSyzygyTables "true" -}}
{{"\n"}}
syzygy-paths={{ getenv "LCZERO_SYZYGY_PATHS" "/lczero/resources/syzygy-tables" }}
{{"\n"}}
{{- end -}}

# Other
{{- if getenv "LCZERO_MAX_CONCURRENT_SEARCHERS" -}}
{{"\n"}}max-concurrent-searchers={{ .Env.LCZERO_MAX_CONCURRENT_SEARCHERS }}{{"\n"}}
{{- end -}}

{{- if and (eq (getenv "LCZERO_VERSION") "0.28") (getenv "LCZERO_MULTI_GATHER") -}}
{{"\n"}}# Applies to version 0.28 only
multi-gather={{ .Env.LCZERO_MULTI_GATHER }}{{"\n"}}
{{- end -}}