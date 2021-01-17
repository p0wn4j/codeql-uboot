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

from NtohMacrosCall nmc, Expr expr
where expr = nmc.getExpr()
select nmc, expr.getFile(), expr
