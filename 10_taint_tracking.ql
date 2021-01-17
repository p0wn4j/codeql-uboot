import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NtohMacros extends Macro {
    NtohMacros() {
        this.getName() in ["ntohs", "ntohl", "ntohll"]
    }
}

class NtohMacrosCall extends MacroInvocation {
    NtohMacrosCall(){
        this.getMacro() instanceof NtohMacros
    }
}

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {

      exists(NtohMacrosCall nmc |
            this = nmc.getExpr()
      )
    } 
}

class MemcpyFunction extends Function {
    MemcpyFunction() {
        this.hasName("memcpy")
    }
}

class MemcpyFunctionCall extends FunctionCall {
    MemcpyFunctionCall(){
        this.getTarget() instanceof MemcpyFunction
    }
}

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFuncLength" }
  
    override predicate isSource(DataFlow::Node source) {
        source.asExpr() instanceof NetworkByteSwap
    }
    override predicate isSink(DataFlow::Node sink) {
      exists(MemcpyFunctionCall mfc | mfc.getArgument(2) = sink.asExpr())
    }
  }
  
from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
