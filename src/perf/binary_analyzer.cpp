#include "baguatool.h"

int main(int argc, char *argv[]) {
  auto static_analysis = std::make_unique<baguatool::collector::StaticAnalysis>(argv[1]);
  static_analysis->CaptureProgramCallGraph();
  static_analysis->IntraProceduralAnalysis();

  static_analysis->DumpProgramCallGraph();
  static_analysis->DumpAllControlFlowGraph();
}
