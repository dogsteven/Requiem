
extension RequiemInstruction {
    public static func subroutineConstant(name: String) -> RequiemInstruction { RequiemSubroutineConstantInstruction(name: name) }
}

fileprivate struct RequiemSubroutineConstantInstruction: RequiemStorageFreeInstruction {
    public let name: String
    
    func act(register: inout RequiemRegister, environment: RequiemEnvironment) -> RequiemInstructionActionResult {
        do {
            let subroutine = try environment.subroutine(of: name)
            
            register.push(.object(value: subroutine))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}
