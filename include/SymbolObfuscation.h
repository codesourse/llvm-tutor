#include "llvm/Pass.h"

#define DEBUG_TYPE "symbolobf"

namespace llvm {
    ModulePass* createSymbolObfuscationPass();
//    void initializeSymbolObfuscationPass(PassRegistry &Registry);
}
