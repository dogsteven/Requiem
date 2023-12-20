
public protocol RequiemInstruction {
    func act(register: inout RequiemRegister, storage: inout RequiemStorage, environment: RequiemEnvironment) -> RequiemInstructionActionResult
}

public enum RequiemInstructionActionResult {
    case `continue`
    case jump(offset: Int)
    case yieldSubroutine(RequiemSubroutine)
    case `return`
    case halt
    case error(Error)
}

public protocol RequiemStorageFreeInstruction: RequiemInstruction {
    func act(register: inout RequiemRegister, environment: RequiemEnvironment) -> RequiemInstructionActionResult
}

public protocol RequiemEnvironmentFreeInstruction: RequiemInstruction {
    func act(register: inout RequiemRegister, storage: inout RequiemStorage) -> RequiemInstructionActionResult
}

public protocol RequiemStorageAndEnvironmentFreeInstruction: RequiemStorageFreeInstruction, RequiemEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult
}

extension RequiemStorageFreeInstruction {
    public func act(register: inout RequiemRegister, storage: inout RequiemStorage, environment: RequiemEnvironment) -> RequiemInstructionActionResult {
        return act(register: &register, environment: environment)
    }
}

extension RequiemEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister, storage: inout RequiemStorage, environment: RequiemEnvironment) -> RequiemInstructionActionResult {
        return act(register: &register, storage: &storage)
    }
}

extension RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister, storage: inout RequiemStorage) -> RequiemInstructionActionResult {
        return act(register: &register)
    }
    
    public func act(register: inout RequiemRegister, environment: RequiemEnvironment) -> RequiemInstructionActionResult {
        return act(register: &register)
    }
    
    public func act(register: inout RequiemRegister, storage: inout RequiemStorage, environment: RequiemEnvironment) -> RequiemInstructionActionResult {
        return act(register: &register)
    }
}
