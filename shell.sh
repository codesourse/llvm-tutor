#export LLVM_DIR_OPT=/opt/homebrew/Cellar/llvm@13/13.0.1_2/bin/opt
#export LLVM_DIR_CLANG=/opt/homebrew/Cellar/llvm@13/13.0.1_2/bin/clang

#export LLVM_DIR_OPT=/opt/homebrew/Cellar/llvm/15.0.3/bin/opt
#export LLVM_DIR_CLANG=/opt/homebrew/Cellar/llvm/15.0.3/bin/clang

export LLVM_DIR=/opt/homebrew/Cellar/llvm@13/13.0.1_2
#export LLVM_DIR=/opt/homebrew/Cellar/llvm/15.0.3

export LLVM_TUTOR_DIR=/Users/xiakejie/ME/break/llvm-tutor



rm -rf -r ./build_obfu

folder="./build_obfu"

if [ ! -x "$folder" ]; then

mkdir $folder

cd $folder
cmake -DLT_LLVM_INSTALL_DIR=$LLVM_DIR  $LLVM_TUTOR_DIR/obfu/
make

else

cd $folder

fi

rm -rf /Users/xiakejie/ME/break/llvm-tutor/demo/testmbaadd/Pods/lib/libobfu.dylib

cp /Users/xiakejie/ME/break/llvm-tutor/build_obfu/libobfu.dylib /Users/xiakejie/ME/break/llvm-tutor/demo/testmbaadd/Pods/lib/libobfu.dylib

cd /Users/xiakejie/ME/break/llvm-tutor/demo/testmbaadd

pod install

exit

rm -rf -r ./build_hello

folder="./build_hello"

if [ ! -x "$folder" ]; then

mkdir $folder
cp ./luck.bc $folder/hello.bc
cd $folder
cmake -DLT_LLVM_INSTALL_DIR=$LLVM_DIR  $LLVM_TUTOR_DIR/HelloWorld/
make

else

cd $folder

fi


$LLVM_DIR/bin/clang -O1 -S -emit-llvm  $LLVM_TUTOR_DIR/inputs/input_for_hello.c -o input_for_hello.ll

$LLVM_DIR/bin/opt  -load  libHelloWorld.dylib -hello ./hello.bc -o /dev/null -time-passes  -enable-new-pm=0
 
$LLVM_DIR/bin/opt -load  ./libHelloWorld.dylib -help | grep hello



cd ..

rm -rf -r ./build

build="./build"

if [ ! -x "$build" ]; then

mkdir build
cp ./luck.bc $build/hello.bc
cd $build
cmake -DLT_LLVM_INSTALL_DIR=$LLVM_DIR  ../
make

else

cd $build

fi



printf "\n===-------------------------------------1------------------------------------===\n"


$LLVM_DIR/bin/clang -emit-llvm -c $LLVM_TUTOR_DIR/inputs/input_for_cc.c -o input_for_cc.bc
# Run the pass through opt
$LLVM_DIR/bin/opt -load-pass-plugin ./lib/libOpcodeCounter.dylib --passes="print<opcode-counter>" -disable-output input_for_cc.bc

printf "\n===-------------------------------------2------------------------------------===\n"


$LLVM_DIR/bin/opt -load-pass-plugin ./lib/libOpcodeCounter.dylib --passes='default<Os>' input_for_cc.bc

#$LLVM_DIR/bin/opt -load ./lib/libOpcodeCounter.dylib -O1 input_for_cc.bc


printf "\n===-------------------------------------2------------------------------------===\n"


# Generate an LLVM file to analyze
$LLVM_DIR/bin/clang -O0 -emit-llvm -c $LLVM_TUTOR_DIR/inputs/input_for_hello.c -o input_for_hello.bc
# Run the pass through opt - New PM
$LLVM_DIR/bin/opt -load-pass-plugin ./lib/libInjectFuncCall.dylib --passes="inject-func-call" input_for_hello.bc -o instrumented.bin
# Run the pass through opt - Legacy PM
$LLVM_DIR/bin/opt -enable-new-pm=0 -load ./lib/libInjectFuncCall.dylib -legacy-inject-func-call input_for_hello.bc -o instrumented.bin

$LLVM_DIR/bin/lli instrumented.bin

printf "\n===-------------------------------------3------------------------------------===\n"
exit


# Generate an LLVM file to analyze
$LLVM_DIR/bin/clang -emit-llvm -c $LLVM_TUTOR_DIR/inputs/input_for_cc.c -o input_for_cc.bc
# Run the pass through opt - Legacy PM
$LLVM_DIR/bin/opt -enable-new-pm=0 -load ./lib/libStaticCallCounter.dylib -legacy-static-cc -analyze input_for_cc.bc


printf "\n===-------------------------------------4------------------------------------===\n"

# Generate an LLVM file to analyze
$LLVM_DIR/bin/clang -emit-llvm -c $LLVM_TUTOR_DIR/inputs/input_for_cc.c -o input_for_cc.bc
# Instrument the input file
$LLVM_DIR/bin/opt -load-pass-plugin=./lib/libDynamicCallCounter.dylib -passes="dynamic-cc" input_for_cc.bc -o instrumented_bin

$LLVM_DIR/bin/lli  ./instrumented_bin

printf "\n===-------------------------------------5------------------------------------===\n"


$LLVM_DIR/bin/clang -emit-llvm -S $LLVM_TUTOR_DIR/inputs/input_for_mba_sub.c -o input_for_sub.ll
$LLVM_DIR/bin/opt -load-pass-plugin=./lib/libMBASub.dylib -passes="mba-add" -S input_for_sub.ll -o out.ll

printf "\n===-------------------------------------6------------------------------------===\n"


$LLVM_DIR/bin/clang -O1 -emit-llvm -S $LLVM_TUTOR_DIR/inputs/input_for_mba.c -o input_for_mba.ll
$LLVM_DIR/bin/opt -load-pass-plugin=./lib/libMBAAdd.dylib -passes="mba-add" -S input_for_mba.ll -o out.ll

printf "\n===-------------------------------------7------------------------------------===\n"


$LLVM_DIR/bin/clang -O1 -emit-llvm -S $LLVM_TUTOR_DIR/inputs/input_for_mba.c -o input_for_mba.ll
$LLVM_DIR/bin/opt -load-pass-plugin=./lib/libMBAAdd.dylib -passes="mba-add" -S input_for_mba.ll -o out.ll
$LLVM_DIR/bin/opt -load ./lib/libMBAAdd.dylib -legacy-mba-add -mba-ratio=0.3 $LLVM_TUTOR_DIR/inputs/input_for_mba.c -o out.ll

printf "\n===-------------------------------------8------------------------------------===\n"


# Generate an LLVM file to analyze
$LLVM_DIR/bin/clang -emit-llvm -S -O1 $LLVM_TUTOR_DIR/inputs/input_for_riv.c -o input_for_riv.ll
# Run the pass through opt - Legacy PM
$LLVM_DIR/bin/opt -load-pass-plugin ./lib/libRIV.dylib -passes="print<riv>" -disable-output input_for_riv.ll


printf "\n===-------------------------------------9------------------------------------===\n"


$LLVM_DIR/bin/clang -emit-llvm -S -O1 $LLVM_TUTOR_DIR/inputs/input_for_duplicate_bb.c -o input_for_duplicate_bb.ll

$LLVM_DIR/bin/opt -load-pass-plugin ./lib/libRIV.dylib -load-pass-plugin ./lib/libDuplicateBB.dylib -passes=duplicate-bb -S input_for_duplicate_bb.ll -o duplicate.ll

$LLVM_DIR/bin/opt -load ./lib/libMergeBB.dylib -legacy-merge-bb -S foo.ll -o merge.ll


printf "\n===-------------------------------------10------------------------------------===\n"


$LLVM_DIR/bin/clang -emit-llvm -S -O1 $LLVM_TUTOR_DIR/inputs/input_for_duplicate_bb.c -o input_for_duplicate_bb.ll

$LLVM_DIR/bin/opt -load-pass-plugin ./lib/libRIV.dylib -load-pass-plugin ./lib/libMergeBB.dylib -load-pass-plugin ./lib/libDuplicateBB.dylib -passes=duplicate-bb,merge-bb -S input_for_duplicate_bb.ll -o merge_after_duplicate.ll

 
printf "\n===-------------------------------------11------------------------------------===\n"

# Generate the input file
$LLVM_DIR/bin/clang -emit-llvm -S -c $LLVM_TUTOR_DIR/inputs/input_for_fcmp_eq.c -o input_for_fcmp_eq.ll
# Run the pass
$LLVM_DIR/bin/opt --load-pass-plugin ./lib/libFindFCmpEq.dylib --passes="print<find-fcmp-eq>" -disable-output input_for_fcmp_eq.ll

printf "\n===-------------------------------------12------------------------------------===\n"

 
$LLVM_DIR/bin/clang -emit-llvm -S -Xclang -disable-O0-optnone \
  -c ./inputs/input_for_fcmp_eq.c -o input_for_fcmp_eq.ll
  
$LLVM_DIR/bin/opt --load-pass-plugin ./lib/libFindFCmpEq.dylib \
  --load-pass-plugin ./lib/libConvertFCmpEq.dylib \
  --passes=convert-fcmp-eq -S input_for_fcmp_eq.ll -o fcmp_eq_after_conversion.ll
  
$LLVM_DIR/bin/opt -load ./lib/libFindFCmpEq.dylib \
  ./lib/libConvertFCmpEq.dylib -convert-fcmp-eq \
  -S input_for_fcmp_eq.ll -o fcmp_eq_after_conversion.ll
  
printf "\n\n\n===-------------------------------------13------------------------------------===\n\n\n"

  
$LLVM_DIR/bin/clang -emit-llvm -S -O1 $LLVM_TUTOR_DIR/inputs/input_for_mba.c -o input_for_mba.ll

$LLVM_DIR/bin/opt -S -load-pass-plugin ./lib/libMBAAdd.dylib -passes=mba-add input_for_mba.ll -debug-only=mba-add -stats -o out.ll
  
printf "\n\n\n===-------------------------------------14------------------------------------===\n\n\n"


#clang   -O1 -S -emit-llvm  ./inputs/input_for_hello.c -o input_for_hello.ll
#opt13 -load  ./libHelloWorld.dylib -help | grep hello
#opt15  -load  ./libHelloWorld.dylib -help | grep hello



