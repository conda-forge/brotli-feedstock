echo "--------------------------"
echo "Installing brotli binaries"

set CMAKE_CONFIG=Release
pushd build_shared_%CMAKE_CONFIG%

echo on

cmake --build . --target install
if errorlevel 1 exit 1