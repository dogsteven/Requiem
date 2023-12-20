
extension RequiemInstruction {
    public static var `true`: RequiemInstruction { RequiemTrueInstruction() }
    
    public static var `false`: RequiemInstruction { RequiemFalseInstruction() }
    
    public static var not: RequiemInstruction { RequiemNotInstruction() }
    
    public static var or: RequiemInstruction { RequiemOrInstruction() }
    
    public static var and: RequiemInstruction { RequiemAndInstruction() }
}

fileprivate struct RequiemTrueInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        register.push(.boolean(value: true))
        
        return .continue
    }
}

fileprivate struct RequiemFalseInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        register.push(.boolean(value: false))
        
        return .continue
    }
}

fileprivate struct RequiemNotInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .boolean(value) = value else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: !value))

            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemOrInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .boolean(lhs) = lhs,
                case let .boolean(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs || rhs))

            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemAndInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .boolean(lhs) = lhs,
                case let .boolean(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs && rhs))

            return .continue
        } catch {
            return .error(error)
        }
    }
}
