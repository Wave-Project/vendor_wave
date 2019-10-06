function __print_wave_functions_help() {
cat <<EOF
Additional functions:
- mka:             Builds using SCHED_BATCH on all processors.
- brunch:          Automatically lunches, clones dependencies if any and builds the ROM
EOF
}

# Initial setup before building
function build_setup() {
    # Fixup display HAL
    source $ANDROID_BUILD_TOP/vendor/wave/build/disp_hals_setup.sh

    # Run hidl-gen script
    if [ -f $ANDROID_BUILD_TOP/$QTI_BUILDTOOLS_DIR/build/update-vendor-hal-makefiles.sh ]; then
        vendor_hal_script=$ANDROID_BUILD_TOP/$QTI_BUILDTOOLS_DIR/build/update-vendor-hal-makefiles.sh
        source $vendor_hal_script --check
        regen_needed=$?
    else
        vendor_hal_script=$ANDROID_BUILD_TOP/vendor/wave/scripts/vendor_hal_makefile_generator.sh
        regen_needed=1
    fi

    if [ $regen_needed -eq 1 ]; then
        _wrap_build $(get_make_command hidl-gen) hidl-gen ALLOW_MISSING_DEPENDENCIES=true
        RET=$?
        if [ $RET -ne 0 ]; then
            echo -n "${color_failed}#### hidl-gen compilation failed, check above errors"
            echo " ####${color_reset}"
            return $RET
        fi
        source $vendor_hal_script
        RET=$?
        if [ $RET -ne 0 ]; then
            echo -n "${color_failed}#### HAL file .bp generation failed dure to incpomaptible HAL files , please check above error log"
            echo " ####${color_reset}"
            return $RET
        fi
    fi
}

# Make using all available CPUs, assume hyperthreading is available
function mka() {
    build_setup
    m -j $(($(nproc --all) * 2)) "$@"
}

# Lunch and mka bacon
function brunch()
{
    if lunch wave_$1-userdebug; then
        time mka bacon
    else
        echo -e "\nNo such item in lunch menu - either you haven't cloned device sources or they are messed up"
        return 1
    fi
    return $?
}
