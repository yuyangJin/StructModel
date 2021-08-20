# Try to find BaguaTool headers and libraries.
#
# Usage of this module as follows:
#
#     find_package(BaguaTool)
#
# Variables used by this module, they can change the default behaviour and need
# to be set before calling find_package:
#
#  BAGUA_PREFIX         Set this variable to the root installation of
#                      libpapi if the module has problems finding the
#                      proper installation path.
#
# Variables defined by this module:
#
#  BAGUA_FOUND              System has PAPI libraries and headers
#  BAGUA_LIBRARIES          The PAPI library
#  BAGUA_INCLUDE_DIRS       The location of PAPI headers

find_path(BAGUA_PREFIX
    NAMES include/baguatool.h
)

find_library(BAGUA_LIBRARIES
    # Pick the static library first for easier run-time linking.
    NAMES libbaguatool.so libbaguatool.a papi
    HINTS ${BAGUA_PREFIX}/lib ${HILTIDEPS}/lib
)

find_path(BAGUA_INCLUDE_DIRS
    NAMES baguatool.h
    HINTS ${BAGUA_PREFIX}/include ${HILTIDEPS}/include
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(BaguaTool DEFAULT_MSG
    BAGUA_LIBRARIES
    BAGUA_INCLUDE_DIRS
)

mark_as_advanced(
    BAGUA_PREFIX
    BAGUA_LIBRARIES
    BAGUA_INCLUDE_DIRS
)