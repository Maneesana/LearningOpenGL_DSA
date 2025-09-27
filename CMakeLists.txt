
cmake_minimum_required(VERSION 3.20)

project(GraphicsDSALearning)

set(CMAKE_CXX_STANDARD 17)

# Find packages installed via vcpkg
find_package(glfw3 REQUIRED)
find_package(glm CONFIG REQUIRED)  # Use CONFIG mode for vcpkg header-only package

add_executable(${PROJECT_NAME} 
src/main.cpp
external/glad/src/glad.c
)

# Link libraries that actually have binaries
target_link_libraries(${PROJECT_NAME} PRIVATE glfw)

# Include directories (GLM is header-only, vcpkg sets this automatically)
target_include_directories(${PROJECT_NAME} PRIVATE 
${GLFW_INCLUDE_DIRS} 
${GLAD_INCLUDE_DIRS} 
external/glad/include
)
