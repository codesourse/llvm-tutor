#export LLVM_DIR_OPT=/opt/homebrew/Cellar/llvm@13/13.0.1_2/bin/opt
#export LLVM_DIR_CLANG=/opt/homebrew/Cellar/llvm@13/13.0.1_2/bin/clang
#export LLVM_DIR=/opt/homebrew/Cellar/llvm@13/13.0.1_2
export LLVM_DIR=/opt/homebrew/Cellar/llvm/15.0.3/

#export LLVM_DIR_OPT=/opt/homebrew/Cellar/llvm/15.0.3/bin/opt
#export LLVM_DIR_CLANG=/opt/homebrew/Cellar/llvm/15.0.3/bin/clang

export LLVM_TUTOR_DIR=/Users/xiakejie/ME/break/llvm-tutor 

rm -rf -r ./build
mkdir build
cp ./luck.bc ./build/hello.bc
cd build
cmake -DLT_LLVM_INSTALL_DIR=$LLVM_DIR  $LLVM_TUTOR_DIR/
make

#clang -O1 -S -emit-llvm  $LLVM_TUTOR_DIR/inputs/input_for_hello.c -o input_for_hello.ll
#
#opt  -load  libHelloWorld.dylib -legacy-hello-world ./hello.bc -o /dev/null -time-passes  -enable-new-pm=0
#
#opt -load  ./libHelloWorld.dylib -help | grep hello
#
#
#clang -emit-llvm -c $LLVM_TUTOR_DIR/inputs/input_for_cc.c -o input_for_cc.bc
#
#opt -load-pass-plugin $LLVM_TUTOR_DIR/lib/libOpcodeCounter.dylib --passes="print<opcode-counter>" -disable-output input_for_cc.bc
#
cd ..


#clang   -O1 -S -emit-llvm  ./inputs/input_for_hello.c -o input_for_hello.ll
#opt13 -load  ./libHelloWorld.dylib -help | grep hello
#opt15  -load  ./libHelloWorld.dylib -help | grep hello

