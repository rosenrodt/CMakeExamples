# better remove CMake generated files before starting anew
rm .build -r
rm .install -r

# build library
cmake -Hmylib -B.build/mylib -DCMAKE_INSTALL_PREFIX=$PWD/.install -DBUILD_SHARED_LIBS=ON
cmake --build .build/mylib --target install --config Release

# build exe
cmake -Hmyexe -B.build/myexe -DCMAKE_INSTALL_PREFIX=$PWD/.install -DCMAKE_PREFIX_PATH=$PWD/.install
cmake --build .build/myexe --target install --config Release

# run built exe
./.install/bin/myexe