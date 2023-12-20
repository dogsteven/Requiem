
extension RequiemInstruction {
    public static var `return`: RequiemInstruction { RequiemReturnInstruction() }
    
    public static var call: RequiemInstruction { RequiemCallInstruction() }
    
    public static func jump(offset: Int) -> RequiemInstruction { RequiemJumpInstruction(offset: offset) }
    
    public static func jumpIf(offset: Int) -> RequiemInstruction { RequiemJumpIfInstruction(offset: offset) }
    
    public static func jumpIfNot(offset: Int) -> RequiemInstruction { RequiemJumpIfNotInstruction(offset: offset) }
}

fileprivate struct RequiemReturnInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        return .return
    }
}

fileprivate struct RequiemCallInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let subroutine = try register.pop()
            
            guard
                case let .object(subroutine) = subroutine,
                let subroutine = subroutine as? RequiemSubroutine
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            return .yieldSubroutine(subroutine)
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemJumpInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public let offset: Int
    
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        return .jump(offset: offset)
    }
}

fileprivate struct RequiemJumpIfInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public let offset: Int
    
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let condition = try register.pop()
            
            guard case let .boolean(condition) = condition else {
                return .error(RequiemInvalidOperandError())
            }
            
            if condition {
                return .jump(offset: offset)
            } else {
                return .continue
            }
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemJumpIfNotInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public let offset: Int
    
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let condition = try register.pop()
            
            guard case let .boolean(condition) = condition else {
                return .error(RequiemInvalidOperandError())
            }
            
            if !condition {
                return .jump(offset: offset)
            } else {
                return .continue
            }
        } catch {
            return .error(error)
        }
    }
}
