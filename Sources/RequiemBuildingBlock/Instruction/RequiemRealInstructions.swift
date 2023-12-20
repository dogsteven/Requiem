
extension RequiemInstruction {
    public static func realConstant(constant: Double) -> RequiemInstruction { RequiemRealConstantInstruction(constant: constant) }
    
    public static var realOpposite: RequiemInstruction { RequiemRealOppositeInstruction() }
    
    public static var realAdd: RequiemInstruction { RequiemRealAddInstruction() }
    
    public static var realSubtract: RequiemInstruction { RequiemRealSubtractInstruction() }
    
    public static var realMultiply: RequiemInstruction { RequiemRealMultiplyInstruction() }
    
    public static var realDivide: RequiemInstruction { RequiemRealDivideInstruction() }
    
    public static var realEqual: RequiemInstruction { RequiemRealEqualInstruction() }
    
    public static var realNotEqual: RequiemInstruction { RequiemRealNotEqualInstruction() }
    
    public static var realLess: RequiemInstruction { RequiemRealLessInstruction() }
    
    public static var realLessEqual: RequiemInstruction { RequiemRealLessEqualInstruction() }
    
    public static var realGreater: RequiemInstruction { RequiemRealGreaterInstruction() }
    
    public static var realGreaterEqual: RequiemInstruction { RequiemRealGreaterEqualInstruction() }
    
    public static var realRound: RequiemInstruction { RequiemRealRoundInstruction() }
    
    public static var realRoundUp: RequiemInstruction { RequiemRealRoundUpInstruction() }
    
    public static var realRoundDown: RequiemInstruction { RequiemRealRoundDownInstruction() }
    
    public static var realToInteger: RequiemInstruction { RequiemRealToIntegerInstruction() }
}

fileprivate struct RequiemRealConstantInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public let constant: Double
    
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        register.push(.real(value: constant))
        
        return .continue
    }
}

fileprivate struct RequiemRealOppositeInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .real(value) = value else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.real(value: -value))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealAddInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.real(value: lhs + rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealSubtractInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.real(value: lhs - rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealMultiplyInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.real(value: lhs * rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealDivideInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.real(value: lhs / rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
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

fileprivate struct RequiemRealNotEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.boolean(value: lhs != rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealLessInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.boolean(value: lhs < rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealLessEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.boolean(value: lhs <= rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealGreaterInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.boolean(value: lhs > rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealGreaterEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .real(lhs) = lhs,
                case let .real(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.boolean(value: lhs >= rhs))
            
            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealRoundInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .real(value) = value else {
                return .error((RequiemInvalidOperandError()))
            }
            
            register.push(.real(value: value.rounded()))

            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealRoundUpInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .real(value) = value else {
                return .error((RequiemInvalidOperandError()))
            }
            
            register.push(.real(value: value.rounded(.down)))

            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealRoundDownInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .real(value) = value else {
                return .error((RequiemInvalidOperandError()))
            }
            
            register.push(.real(value: value.rounded(.up)))

            return .continue
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemRealToIntegerInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .real(value) = value else {
                return .error((RequiemInvalidOperandError()))
            }
            
            register.push(.integer(value: Int(value)))

            return .continue
        } catch {
            return .error(error)
        }
    }
}
