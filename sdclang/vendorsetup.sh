# Set SDClang defaults
export SDCLANG=false
export SDCLANG_PATH=vendor/qcom/sdclang-8.0/linux-x86/bin
export SDCLANG_LTO_DEFS=vendor/wave/sdclang/sdllvm-lto-defs.mk
export SDCLANG_COMMON_FLAGS="-O3 -fvectorize -g0 -DNDEBUG -Wno-user-defined-warnings -Wno-vectorizer-no-neon \
-Wno-unknown-warning-option -Wno-deprecated-register -Wno-tautological-type-limit-compare -Wno-sign-compare \
-Wno-gnu-folding-constant -mllvm -arm-implicit-it=always -Wno-inline-asm -Wno-unused-command-line-argument \
-Wno-unused-variable -Wno-sometimes-uninitialized -Wno-shorten-64-to-32 -Wno-defaulted-function-deleted \
-Wno-array-bounds -Wno-atomic-implicit-seq-cst -Wno-c++98-compat-extra-semi -Wno-return-std-move \
-fno-sanitize=implicit-integer-sign-change"

# Enable based on host OS/availablitiy
if [[ $(uname -s) == "Linux" ]]; then export SDCLANG=true; fi
