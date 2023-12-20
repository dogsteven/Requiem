
extension RequiemInstruction {
    public static var pop: RequiemInstruction { RequiemPopInstruction() }
    
    public static var duplicate: RequiemInstruction { RequiemDuplicateInstruction() }
    
    public static var swap: RequiemInstruction { RequiemSwapInstruction() }
    
    public static var over: RequiemInstruction { RequiemOverInstruction() }
    
    public static var rotate: RequiemInstruction { RequiemRotateInstruction() }
}

fileprivate struct RequiemPopInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            try register.pop()
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemDuplicateInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            try register.duplicate()
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemSwapInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            try register.swap()
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemOverInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            try register.over()
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRotateInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            try register.rotate()
            
            return .next
        } catch {
            return .error(error)
        }
    }
}
