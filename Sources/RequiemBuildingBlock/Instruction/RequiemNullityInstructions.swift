
extension RequiemInstruction {
    public static var null: RequiemInstruction { RequiemNullInstruction() }
    
    public static var checkIfNull: RequiemInstruction { RequiemCheckIfNullInstruction() }
}

fileprivate struct RequiemNullInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        register.push(.null)
        
        return .continue
    }
}

fileprivate struct RequiemCheckIfNullInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            switch value {
            case .null:
                register.push(.boolean(value: true))
            default:
                register.push(.boolean(value: false))
            }
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}
