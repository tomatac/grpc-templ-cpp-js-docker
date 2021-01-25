
echo Creating proto files for c++ application in folder: srv-cpp/build/proto
mkdir -p srv-cpp/build/protos
protoc -I ./protos --cpp_out=./srv-cpp/build/protos echo.proto
protoc -I ./protos --grpc_out=./srv-cpp/build/protos --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` echo.proto

echo Creating proto files for javascript application in folder: client-web/build-protos
mkdir -p client-web/build-protos
protoc -I=./protos echo.proto \
    --js_out=import_style=commonjs:./client-web/build-protos \
    --grpc-web_out=import_style=commonjs,mode=grpcwebtext:./client-web/build-protos
