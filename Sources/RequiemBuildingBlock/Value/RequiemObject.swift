
public protocol RequiemObject: AnyObject {}

public final class RequiemUnownedObject: RequiemObject {
    private weak var object: RequiemObject?
    
    public init(object: RequiemObject) {
        self.object = object
    }
    
    public func unwrapped() throws -> RequiemObject {
        guard let object else {
            throw DeallocatedObjectAccessError()
        }
        
        return object
    }
}

extension RequiemUnownedObject {
    public struct DeallocatedObjectAccessError: Error {}
}
