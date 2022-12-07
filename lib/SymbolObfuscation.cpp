
#include "llvm/IR/PassManager.h"
namespace llvm {
    struct SymbolObfuscationPass : PassInfoMixin<SymbolObfuscationPass> {
      PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
    };
}

#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include <string>
#include <iostream>
#include <cstdlib>

using namespace llvm;
using namespace std;

static string obfcharacters="-_.|/\\`+,=()*:";

int seed = 0;
string randomString(int length){
    string name;
    name.resize(length);
    srand(seed);
    seed++;
    for(int i=0;i<length;i++){
        name[i]=obfcharacters[rand()%(obfcharacters.length())];
    }
    return "f_" + name;
}

PreservedAnalyses SymbolObfuscationPass::run(Module &M, ModuleAnalysisManager &AM) {
    //F.setName(randomString(16));
    errs()<<"Start Symbol Rewrite!\n";
    for(Module::iterator Fun=M.begin();Fun!=M.end();Fun++){
        Function &F=*Fun;
        if (F.getName().str().compare("main")==0){
            errs()<<"Skipping main\n";
        }
        else if(F.empty()==false){
            //Rename
            string newname = randomString(16);
            errs()<<"Renaming Function: "<<F.getName()<<"\n";
            errs()<<"New Function Name: "<<newname<<"\n";
            F.setName(newname);
        }
        else{
            errs()<<"Skipping External Function: "<<F.getName()<<"\n";
        }
    }
  return PreservedAnalyses::all();
}

static cl::opt<bool> EnnableObf("symbolobf",cl::init(false),cl::desc("Rewrite Symbols!"))

static RegisterStandardPasses Y(
    PassManagerBuilder::EP_EarlyAsPossible,
    [](const PassManagerBuilder &Builder,
       legacy::PassManagerBase &PM) { PM.add(new SymbolObfuscationPass()); });
