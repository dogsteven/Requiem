
extension RequiemInstruction {
    public static func integerConstant(constant: Int) -> RequiemInstruction { RequiemIntegerConstantInstruction(constant: constant) }
    
    public static var integerOpposite: RequiemInstruction { RequiemIntegerOppositeInstruction() }
    
    public static var integerAdd: RequiemInstruction { RequiemIntegerAddInstruction() }
    
    public static var integerSubtract: RequiemInstruction { RequiemIntegerSubtractInstruction() }
    
    public static var integerMultiply: RequiemInstruction { RequiemIntegerMultiplyInstruction() }
    
    public static var integerDivide: RequiemInstruction { RequiemIntegerDivideInstruction() }
    
    public static var integerModulo: RequiemInstruction { RequiemIntegerModuloInstruction() }
    
    public static var integerBitShift: RequiemInstruction { RequiemIntegerBitShiftInstruction() }
    
    public static var integerBitOr: RequiemInstruction { RequiemIntegerBitXorInstruction() }
    
    public static var integerBitAnd: RequiemInstruction { RequiemIntegerBitAndInstruction() }
    
    public static var integerBitXor: RequiemInstruction { RequiemIntegerBitXorInstruction() }
    
    public static var integerUnsafeOpposite: RequiemInstruction { RequiemIntegerUnsafeOppositeInstruction() }
    
    public static var integerUnsafeAdd: RequiemInstruction { RequiemIntegerUnsafeAddInstruction() }
    
    public static var integerUnsafeSubtract: RequiemInstruction { RequiemIntegerUnsafeSubtractInstruction() }
    
    public static var integerUnsafeMultiply: RequiemInstruction { RequiemIntegerUnsafeMultiplyInstruction() }
    
    public static var integerUnsafeDivide: RequiemInstruction { RequiemIntegerUnsafeDivideInstruction() }
    
    public static var integerUnsafeModulo: RequiemInstruction { RequiemIntegerUnsafeModuloInstruction() }
    
    public static var integerEqual: RequiemInstruction { RequiemIntegerEqualInstruction() }
    
    public static var integerNotEqual: RequiemInstruction { RequiemIntegerNotEqualInstruction() }
    
    public static var integerLess: RequiemInstruction { RequiemIntegerLessInstruction() }
    
    public static var integerLessEqual: RequiemInstruction { RequiemIntegerLessEqualInstruction() }
    
    public static var integerGreater: RequiemInstruction { RequiemIntegerGreaterInstruction() }
    
    public static var integerGreaterEqual: RequiemInstruction { RequiemIntegerGreaterEqualInstruction() }
    
    public static var integerToReal: RequiemInstruction { RequiemIntegerToRealInstruction() }
}

fileprivate struct RequiemIntegerConstantInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public let constant: Int
    
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        register.push(.integer(value: constant))
        
        return .next
    }
}

fileprivate struct RequiemIntegerOppositeInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard
                case let .integer(value) = value
            else {
                return .error(RequiemInvalidOperandError())
            }

            let (result, isOverflow) = Int.zero.subtractingReportingOverflow(value)
            register.push(.integer(value: result))
            register.push(.boolean(value: isOverflow))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerAddInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let (result, isOverflow) = lhs.addingReportingOverflow(rhs)
            register.push(.integer(value: result))
            register.push(.boolean(value: isOverflow))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerSubtractInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let (result, isOverflow) = lhs.subtractingReportingOverflow(rhs)
            register.push(.integer(value: result))
            register.push(.boolean(value: isOverflow))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerMultiplyInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let (result, isOverflow) = lhs.multipliedReportingOverflow(by: rhs)
            register.push(.integer(value: result))
            register.push(.boolean(value: isOverflow))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerDivideInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let (result, isOverflow) = lhs.dividedReportingOverflow(by: rhs)
            register.push(.integer(value: result))
            register.push(.boolean(value: isOverflow))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerModuloInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let (result, isOverflow) = lhs.remainderReportingOverflow(dividingBy: rhs)
            register.push(.integer(value: result))
            register.push(.boolean(value: isOverflow))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerBitShiftInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let shift = min(max(rhs, 0), Int.bitWidth)
            
            if shift >= 0 {
                register.push(.integer(value: lhs << shift))
            } else {
                register.push(.integer(value: lhs >> (-shift)))
            }
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerBitOrInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs | rhs))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerBitAndInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs & rhs))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerBitXorInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs ^ rhs))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerUnsafeOppositeInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard
                case let .integer(value) = value
            else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.integer(value: -value))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerUnsafeAddInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs + rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerUnsafeSubtractInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs - rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerUnsafeMultiplyInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs * rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerUnsafeDivideInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs / rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerUnsafeModuloInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    public func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs,
                rhs != 0
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.integer(value: lhs % rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs == rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerNotEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs != rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerLessInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs < rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerLessEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs <= rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerGreaterInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs > rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerGreaterEqualInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let lhs = try register.pop()
            let rhs = try register.pop()
            
            guard
                case let .integer(lhs) = lhs,
                case let .integer(rhs) = rhs
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            register.push(.boolean(value: lhs >= rhs))

            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemIntegerToRealInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let value = try register.pop()
            
            guard case let .integer(value) = value else {
                return .error(RequiemInvalidOperandError())
            }

            register.push(.real(value: Double(value)))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}
