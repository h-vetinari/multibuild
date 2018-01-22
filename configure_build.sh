# Find, load common utilities
# Defines IS_OSX, fetch_unpack
MULTIBUILD_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MULTIBUILD_DIR/common_utils.sh

PLAT="${PLAT:x86_64}"
BUILD_PREFIX="${BUILD_PREFIX:-/usr/local}"

# Default compilation flags for OSX
# IS_OSX is defined in common_utils.sh
if [ -n "$IS_OSX" ]; then
    # Dual arch build by default
    ARCH_FLAGS=${ARCH_FLAGS:-"-arch i386 -arch x86_64"}
    # Only set CFLAGS, FFLAGS if they are not already defined.  Build functions
    # can override the arch flags by setting CFLAGS, FFLAGS
    export CFLAGS="${CFLAGS:-$ARCH_FLAGS}"
    export CXXFLAGS="${CXXFLAGS:-$ARCH_FLAGS}"
    export FFLAGS="${FFLAGS:-$ARCH_FLAGS}"
fi

# Promote BUILD_PREFIX on search path to any newly built libs
export CPPFLAGS="-L$BUILD_PREFIX/include $CPPFLAGS"
export LIBRARY_PATH="$BUILD_PREFIX/lib:$LIBRARY_PATH"
