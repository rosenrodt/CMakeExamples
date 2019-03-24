# rm -r .build # debug
# rm -r .install

# Add the standalone toolchain to the search path.
export PATH=$PATH:/mnt/d/tools/android/android_toolchain_linux/bin

# Tell configure what tools to use.
target_host=aarch64-linux-android
export AR=$target_host-ar
export AS=$target_host-clang
export CC=$target_host-clang
export CXX=$target_host-clang++
export LD=$target_host-ld
export STRIP=$target_host-strip

# Tell configure what flags Android requires.
export CFLAGS="-fPIE -fPIC"
export LDFLAGS="-pie"

# Invoke CMake to generate Makefiles (default on Linux)
# go to `CMakeLists.txt` to see what is actually scripted to be done
cmake . -B.build -DCMAKE_INSTALL_PREFIX=$PWD/.install

# Invoke CMake's build mode, which is really just calling `make`
cmake --build .build --target install --config Release

# Test exe on android
adb start-server                            # initialize adb
adb root                                    # gain device root access
adb push .install/bin/test_main data/local  # push exe to device
adb shell ./data/local/test_main            # run exe