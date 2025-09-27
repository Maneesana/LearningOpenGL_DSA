#!/usr/bin/env bash

set -e # exit immediately if a command fails
set -o pipefail

PROJECT_NAME="GraphicsDSALearning"
BUILD_DIR="build"

# Step 1: clean build dir if it exists
if [ -d "$BUILD_DIR" ]; then
	echo "🧹 Removing old build directory..."
	rm -rf "$BUILD_DIR"
fi

if [ -d "vcpkg_installed"]; then
	rm -rf vcpkg_installed
fi

# Installing libraries using vcpkg 
vcpkg install --triplet x64-osx

# Step 2: create new build dir
echo "📂 Creating build directory..."
mkdir "$BUILD_DIR"
cd "$BUILD_DIR"

# Step 3: run cmake

# User can override vcpkg path 

VCPKG_ROOT  = "${VCPKG_ROOT:/opt/vcpkg}"

if [ ! -f "$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"]; then 
			echo "ERROR: vcpkg not found in $VCPKG_ROOT"
			exit 1
fi
echo "⚙️ Configuring project with CMake..."
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"

# Step 4: build with make
echo "🔨 Building project..."
make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu)
# cmake --build .

# Step 5: run the executable
echo "🚀 Running $PROJECT_NAME..."
./$PROJECT_NAME
