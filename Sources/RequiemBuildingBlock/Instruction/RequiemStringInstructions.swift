
extension RequiemInstruction {
    public static func stringConstant(constant: String) -> RequiemInstruction { RequiemStringConstantInstruction(constant: constant) }
    
    public static var stringLength: RequiemInstruction { RequiemStringLengthInstruction() }
    
    public static var stringSubscript: RequiemInstruction { RequiemStringSubscriptInstruction() }
    
    public static var stringSubstring: RequiemInstruction { RequiemStringSubstringInstruction() }
    
    public static var stringConcatenate: RequiemInstruction { RequiemStringConcatenateInstruction() }
    
    public static var stringEqual: RequiemInstruction { RequiemStringEqualInstruction() }
}

fileprivate struct RequiemStringConstantInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public let constant: String
    
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        register.push(.string(value: constant))
        
        return .continue
    }
}

fileprivate struct RequiemStringLengthInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let string = try register.pop()
            
            guard case let .string(string) = string else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: string.count))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemStringSubscriptInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let string = try register.pop()
            let offset = try register.pop()
            
            guard
                case let .string(string) = string,
                case let .integer(offset) = offset,
                offset >= 0,
                let index = string.index(string.startIndex, offsetBy: offset, limitedBy: string.endIndex)
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.string(value: String(string[index])))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemStringSubstringInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let string = try register.pop()
            let leftOffset = try register.pop()
            let rightOffset = try register.pop()
            
            guard
                case let .string(string) = string,
                case let .integer(leftOffset) = leftOffset,
                case let .integer(rightOffset) = rightOffset,
                leftOffset >= 0 && rightOffset >= 0 && leftOffset <= rightOffset,
                let leftIndex = string.index(string.startIndex, offsetBy: leftOffset, limitedBy: string.endIndex),
                let rightIndex = string.index(string.startIndex, offsetBy: rightOffset, limitedBy: string.endIndex)
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.string(value: String(string[leftIndex..<rightIndex])))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemStringConcatenateInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .string(lhs) = lhs,
                case let .string(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.string(value: lhs + rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemStringEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .string(lhs) = lhs,
                case let .string(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs == rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}
