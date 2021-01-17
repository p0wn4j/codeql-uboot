import cpp

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

from MemcpyFunctionCall mfc
select mfc
