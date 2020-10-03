echo "--------------------------"
echo "Installing brotli binaries"

set CMAKE_CONFIG=Release

echo on

cmake --build . --target install
if errorlevel 1 exit 1