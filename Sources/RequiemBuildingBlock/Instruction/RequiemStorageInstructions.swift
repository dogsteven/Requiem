
extension RequiemInstruction {
    public static func readStorage(index: UInt8) -> RequiemInstruction { RequiemReadStorageInstruction(index: index) }
    
    public static func writeStorage(index: UInt8) -> RequiemInstruction { RequiemWriteStorageInstruction(index: index) }
}

fileprivate struct RequiemReadStorageInstruction: RequiemEnvironmentFreeInstruction {
    public let index: UInt8
    
    func act(register: inout RequiemRegister, storage: inout RequiemStorage) -> RequiemInstructionActionResult {
        do {
            let value = try storage.readStorage(index: index)
            register.push(value)
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemWriteStorageInstruction: RequiemEnvironmentFreeInstruction {
    public let index: UInt8
    
    func act(register: inout RequiemRegister, storage: inout RequiemStorage) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            try storage.writeStorage(index: index, value: value)
            
            return .next
        } catch {
            return .error(error)
        }
    }
}
