cmake_minimum_required(VERSION 2.8.12)

# set RUNPATH to the directory the exe resides: $ORIGIN
# so when you put together the exe and dll it will load correctly
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH}:\$ORIGIN") # escape $ with \ for correct parsing

find_package(mylib REQUIRED)

add_executable(myexe main.c)
target_link_libraries(myexe PRIVATE mylib::mylib)

install(TARGETS myexe DESTINATION bin)
