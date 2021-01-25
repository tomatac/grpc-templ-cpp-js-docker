cmake_minimum_required(VERSION 3.16.0)
project(grpc-templ-srv-echo VERSION 0.1.0)

set(CMAKE_VERBOSE_MAKEFILE ON)

### Require out-of-source builds
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel free to remove CMakeCache.txt and CMakeFiles.")
endif()

# This maybe used if gRPC is not installed system wide
# gRPC is downloaded and built within a subfolder of current project
#include(FetchContent)
#FetchContent_Declare(
#  gRPC
#  GIT_REPOSITORY https://github.com/grpc/grpc
#  GIT_TAG        v1.32.0  # e.g v1.28.0
#)
#set(FETCHCONTENT_QUIET OFF)
#FetchContent_MakeAvailable(gRPC)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ADDITIONAL_CFLAGS} -g")
set(CMAKE_BUILD_TYPE Debug)

add_subdirectory(src)


