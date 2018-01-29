set CMAKE_CONFIG=Release

mkdir build_shared_%CMAKE_CONFIG%
pushd build_shared_%CMAKE_CONFIG%

cmake -G "NMake Makefiles" ^
      -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DBUILD_SHARED_LIBS:BOOL=ON ^
      "%SRC_DIR%"
if errorlevel 1 exit 1
nmake
if errorlevel 1 exit 1
ctest -V
if errorlevel 1 exit 1
cmake --build . --target install
if errorlevel 1 exit 1

REM static install would overwrite this; we'll move back later
move "%LIBRARY_BIN%\brotli.exe" "%LIBRARY_BIN%\brotli-tmp.exe"

popd

mkdir build_static_%CMAKE_CONFIG%
pushd build_static_%CMAKE_CONFIG%

cmake -G "NMake Makefiles" ^
      -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DBUILD_SHARED_LIBS:BOOL=OFF ^
      -DCMAKE_RELEASE_POSTFIX="_static" ^
      "%SRC_DIR%"
if errorlevel 1 exit 1
nmake
if errorlevel 1 exit 1
ctest -V
if errorlevel 1 exit 1
cmake --build . --target install
if errorlevel 1 exit 1

move "%LIBRARY_BIN%\brotli.exe" "%LIBRARY_BIN%\brotli_static.exe"
move "%LIBRARY_BIN%\brotli-tmp.exe" "%LIBRARY_BIN%\brotli.exe"

popd
