import cpp

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
  
from NetworkByteSwap n
select n, "Network byte swap" 
