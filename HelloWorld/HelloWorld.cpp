//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/IR/Instructions.h"
#include <string>
#include <iostream>
#include <cstdlib>

using namespace llvm;

#define DEBUG_TYPE "hello"

STATISTIC(HelloCounter, "Counts number of functions greeted");
using namespace std;
static string obfcharacters="qwertyuiopasdfghjklzxcvbnm1234567890";
namespace {
  // Hello - The first implementation, without getAnalysisUsage.
  struct Hello : public FunctionPass {
    int seed = 0;
    static char ID; // Pass identification, replacement for typeid
    Hello() : FunctionPass(ID) {}
    string randomString(int length){
        string name;
        name.resize(length);
        srand(seed);
        seed++;
        for(int i=0;i<length;i++){
            name[i]=obfcharacters[rand()%(obfcharacters.length())];
        }
        return name;
    }
    bool runOnFunction(Function &F) override {
      ++HelloCounter;
      errs() << "文件函数名1: ";
      errs().write_escaped(F.getName()) << '\n';
        
        if (F.getName().str().compare("main")==0){
            errs()<<"Skipping main\n";
        }else if (F.getName().str().compare("function_export")==0){
 
            errs()<<"Skipping Export Function: "<<F.getName()<<"\n";
        }
        else if(F.empty()==false){
            //Rename
            string newname = randomString(16);
            errs()<<"Renaming Function: "<<F.getName()<<" --> New Name: "<<newname<<"\n";
            F.setName(newname);
        }
        else{
            errs()<<"Skipping External Function: "<<F.getName()<<"\n";
        }
      return false;
    }
      
  };
}

char Hello::ID = 0;
static RegisterPass<Hello> X("hello", "Hello World Pass");


static void registerSkeletonPass(const PassManagerBuilder &, legacy::PassManagerBase &PM)
{
   PM.add(new Hello());
}
 
static RegisterStandardPasses RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible, registerSkeletonPass);
