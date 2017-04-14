set CMAKE_CONFIG=Release

mkdir build_shared_%CMAKE_CONFIG%
pushd build_shared_%CMAKE_CONFIG%

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DBUILD_SHARED_LIBS:BOOL=ON ^
      "%SRC_DIR%"
nmake
ctest -V

move bro.exe "%LIBRARY_BIN%\"
move *.dll "%LIBRARY_BIN%\"
move *.lib "%LIBRARY_LIB%\"

popd

mkdir build_static_%CMAKE_CONFIG%
pushd build_static_%CMAKE_CONFIG%

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DBUILD_SHARED_LIBS:BOOL=OFF ^
      -DCMAKE_RELEASE_POSTFIX="_static" ^
      "%SRC_DIR%"

nmake
ctest -V

move bro.exe "%LIBRARY_BIN%\bro_static.exe"
move *.lib "%LIBRARY_LIB%\"
mkdir "%LIBRARY_INC%\brotli"
move "%SRC_DIR%\include\brotli\*" "%LIBRARY_INC%\brotli\"

popd
