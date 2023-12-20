
extension RequiemInstruction {
    public static var resultSuccess: RequiemInstruction { RequiemResultSuccessInstruction() }
    
    public static var resultError: RequiemInstruction { RequiemResultErrorInstruction() }
    
    public static var resultCheckIfSuccess: RequiemInstruction { RequiemResultCheckIfSuccessInstruction() }
    
    public static var resultCheckIfError: RequiemInstruction { RequiemResultCheckIfErrorInstruction() }
    
    public static var resultSuccessUnwrap: RequiemInstruction { RequiemResultSuccessUnwrapInstruction() }
    
    public static var resultErrorUnwrap: RequiemInstruction { RequiemResultErrorUnwrapInstruction() }
}

fileprivate struct RequiemResultSuccessInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            register.push(.result(.success(value: value)))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}


fileprivate struct RequiemResultErrorInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            register.push(.result(.error(value: value)))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemResultCheckIfSuccessInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let resultValue = try register.pop()
            
            guard case let .result(resultValue) = resultValue else {
                return .error(RequiemInvalidOperandError())
            }
            
            switch resultValue {
            case .success:
                register.push(.boolean(value: true))
            case .error:
                register.push(.boolean(value: false))
            }
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemResultCheckIfErrorInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let resultValue = try register.pop()
            
            guard case let .result(resultValue) = resultValue else {
                return .error(RequiemInvalidOperandError())
            }
            
            switch resultValue {
            case .success:
                register.push(.boolean(value: false))
            case .error:
                register.push(.boolean(value: true))
            }
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemResultSuccessUnwrapInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let resultValue = try register.pop()
            
            guard case let .result(resultValue) = resultValue else {
                return .error(RequiemInvalidOperandError())
            }
            
            switch resultValue {
            case .success(let value):
                register.push(value)
            case .error:
                return .error(RequiemInvalidOperandError())
            }
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemResultErrorUnwrapInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let resultValue = try register.pop()
            
            guard case let .result(resultValue) = resultValue else {
                return .error(RequiemInvalidOperandError())
            }
            
            switch resultValue {
            case .success:
                return .error(RequiemInvalidOperandError())
            case .error(let value):
                register.push(value)
            }
            
            return .next
        } catch {
            return .error(error)
        }
    }
}
