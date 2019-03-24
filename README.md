# CMake Examples
**(1) lib_and_exe**
Compiles a shared library (*.so) and link against an executable

**Note**
On Linux, *.so are searched a little differently than on Windows. By default, the *.so loader does not search your working directory nor the directory the exe resides. There are 2 solutions: A) we set exe's `RUNPATH` to `$ORIGIN`, the directory containing the exe. B) Set `LD_LIBRARY_PATH` env variable before running the exe. On the other hand, dumping your *.so into system directory is often a no-go due to restricted root access. For more info see [RPATH handling](https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling)

**(2) opencl_query_android**
Cross-compiles executable that calls OpenCL API and can be `adb push`ed to mobile device and execute in native environemnt, without using Android Studio

**Note**
* Need to specify the path of the cross-compiler in the Bash script. Can be downloaded from Android NDK
* Need Android Debug Bridge in your OS-wide path so you can call `adb`, also downloadble from Android Developers page

***

### Quick start
**CMakeLists.txt syntax**
* Only 2 variable types: variable and list of variables
* Set variable by `set(MY_VAR MY_NEW_VAR)`
* Set list by `list(APPEND MY_LIST MY_NEW_ELEMENT)`
* `${VAR}` are variables, `$<COND>` are conditionals
* Print debug message with `message()`
> ```
> In CMakeLists.txt:
> $ set(VAR whatever)
> $ message("This is a debug message: the variable VAR is ${VAR}")
>
> After invoking CMake:
> This is a debug message: the variable VAR is whatever
> ```
* Variables starting with `CMAKE_` are pre-defined variables
  - `CMAKE_INSTALL_PREFIX`: the directory to which your built binaries be exported as packages
  - `CMAKE_PREFIX_PATH`: the directory CMake search for packages

**CMake commands**
* `cmake -Hsource/dir -Bbuild/dir`: generate project from source folder **source/dir** to **build/dir**
* `cmake --build build/dir --config Release`: build binaries from generated project folder **build/dir** with **Release** mode
