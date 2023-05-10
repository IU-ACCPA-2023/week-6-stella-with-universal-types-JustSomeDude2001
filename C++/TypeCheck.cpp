#include <iostream>
#include "TypeCheck.h"
#include "MyVisitor.h"
#include "Stella/Absyn.H"

namespace Stella
{
  void typecheckProgram(Program *program)
  {
      /**
       * Interesting features beyond requirements specified:
       *
       * Tuples of any size
       * Inference of sum types is supported (I think)
       */
      program->accept(new MyVisitor());
      std::cout << "Typechecking successful";
  }

} // namespace Stella
