
extension RequiemInstruction {
    public static var unownedRefer: RequiemInstruction { RequiemUnownedReferInstruction() }
    
    public static var unownedUnwrap: RequiemInstruction { RequiemUnownedUnwrapInstruction() }
    
    public static var unownedUnsafeUnwrap: RequiemInstruction { RequiemUnownedUnsafeUnwrapInstruction() }
}

fileprivate struct RequiemUnownedReferInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let object = try register.pop()
            
            guard case let .object(object) = object else {
                return .error(RequiemInvalidOperandError())
            }

            if object is RequiemUnownedObject {
                register.push(.object(value: object))
            } else {
                register.push(.object(value: RequiemUnownedObject(object: object)))
            }
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemUnownedUnwrapInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let unownedObject = try register.pop()
            
            guard
                case let .object(unownedObject) = unownedObject,
                let unownedObject = unownedObject as? RequiemUnownedObject
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let object = try? unownedObject.unwrappedObject()
            
            register.push(object.map(RequiemValue.object(value:)) ?? .null)
            
            return .next
        } catch {
            return .error(error)
        }
    }
}

fileprivate struct RequiemUnownedUnsafeUnwrapInstruction: RequiemStorageAndEnvironmentFreeInstruction {
    func act(register: inout RequiemRegister) -> RequiemInstructionActionResult {
        do {
            let unownedObject = try register.pop()
            
            guard
                case let .object(unownedObject) = unownedObject,
                let unownedObject = unownedObject as? RequiemUnownedObject
            else {
                return .error(RequiemInvalidOperandError())
            }
            
            let object = try unownedObject.unwrappedObject()
            
            register.push(.object(value: object))
            
            return .next
        } catch {
            return .error(error)
        }
    }
}
