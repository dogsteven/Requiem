
public struct RequiemStorage: ~Copyable {
    private var values: [RequiemValue]
    
    public init(size: UInt8) {
        self.values = Array(repeating: .null, count: max(Int(size), 0))
    }
    
    public func readStorage(index: UInt8) throws -> RequiemValue {
        guard index < values.count else {
            throw InvalidStorageAccessError()
        }
        
        return values[Int(index)]
    }
    
    public mutating func writeStorage(index: UInt8, value: RequiemValue) throws {
        guard index < values.count else {
            throw InvalidStorageAccessError()
        }
        
        values[Int(index)] = value
    }
}

extension RequiemStorage {
    public struct InvalidStorageAccessError: Error {}
}
