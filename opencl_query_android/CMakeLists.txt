cmake_minimum_required(VERSION 3.0.0)

# set up envs
find_path(OpenCL_INCLUDE_DIRS NAMES "CL/cl.h" PATHS external/qualcomm_ocl/include NO_DEFAULT_PATH)
find_library(OpenCL_LIBRARIES NAMES OpenCL PATHS external/qualcomm_ocl/lib)
file(GLOB libc_LIBRARIES external/libc++/lib/*.so)

# compile
add_executable(test_main src/main.cpp)
target_include_directories(test_main PRIVATE ${OpenCL_INCLUDE_DIRS})
target_link_libraries(test_main PRIVATE ${OpenCL_LIBRARIES} ${libc_LIBRARIES})

# export
install(
    TARGETS test_main
    EXPORT test_main-targets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
)
