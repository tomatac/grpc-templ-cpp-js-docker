message(STATUS "*** src/CMakeList.txt ***")

find_package(Protobuf REQUIRED)
find_package(gRPC REQUIRED)

# these files are generated by a script in the ""../../protos" folder
set(hw_proto_srcs "${CMAKE_CURRENT_BINARY_DIR}/../protos/echo.pb.cc")
set(hw_grpc_srcs "${CMAKE_CURRENT_BINARY_DIR}/../protos/echo.grpc.pb.cc")

set(_PROTOBUF_LIBPROTOBUF protobuf::libprotobuf)
set(_REFLECTION gRPC::grpc++_reflection)
set(_GRPC_GRPCPP gRPC::grpc++)

# Include generated *.pb.h files
include_directories("${CMAKE_CURRENT_BINARY_DIR}/../protos")

add_executable (echo_server echo_server.cc echo_service_impl.cc ${hw_proto_srcs} ${hw_grpc_srcs})
target_link_libraries (echo_server PUBLIC ${_REFLECTION} ${_GRPC_GRPCPP} ${_PROTOBUF_LIBPROTOBUF})
