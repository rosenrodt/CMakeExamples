cmake_minimum_required(VERSION 2.8.12)
project(mylib)

set(CMAKE_DEBUG_POSTFIX d) # append 'd' to debug builds as in *d.pdb *d.lib *d.dll

add_library(mylib mylib.c)

include(GenerateExportHeader)
generate_export_header(mylib
    EXPORT_MACRO_NAME DLL_EXPORT
    EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/include/mylib_export.h)

# $<BUILD_INTERFACE> conditionally add the include directory during build phase
# $<INSTALL_INTERFACE> conditionally add the include directory during install phase
# ${VAR} are variables, $<COND> are conditionals
target_include_directories(mylib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> # mylib/include
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include> # .build/include; for CMake-generated mylib_export.h
    $<INSTALL_INTERFACE:include> # ${CMAKE_PREFIX_PATH}/include
)

# set up install target
install(TARGETS mylib
    EXPORT mylib-targets # CMake config name
    ARCHIVE DESTINATION lib # ${CMAKE_PREFIX_PATH}/lib
    LIBRARY DESTINATION lib # ${CMAKE_PREFIX_PATH}/lib
    RUNTIME DESTINATION bin # ${CMAKE_PREFIX_PATH}/bin
    INCLUDES DESTINATION include # ${CMAKE_PREFIX_PATH}/include
)

install(EXPORT mylib-targets
    NAMESPACE mylib::
    FILE mylib-config.cmake
    DESTINATION lib/cmake/mylib
)

install(FILES include/mylib.h DESTINATION include)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/include/mylib_export.h DESTINATION include)