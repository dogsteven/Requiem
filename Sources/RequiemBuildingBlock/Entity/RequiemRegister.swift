
public struct RequiemRegister: ~Copyable {
    private var values: [RequiemValue]
    
    public init(values: [RequiemValue]) {
        self.values = values
    }
    
    public mutating func push(_ value: RequiemValue) {
        values.append(value)
    }
    
    public func top() throws -> RequiemValue {
        guard let value = values.last else {
            throw InsufficientNumberOfOperandsError()
        }
        
        return value
    }
    
    @discardableResult
    public mutating func pop() throws -> RequiemValue {
        guard let value = values.popLast() else {
            throw InsufficientNumberOfOperandsError()
        }
        
        return value
    }
    
    @discardableResult
    public mutating func pop(count: Int) throws -> [RequiemValue] {
        guard count <= values.count else {
            throw InsufficientNumberOfOperandsError()
        }
        
        guard count > 0 else {
            return []
        }
        
        defer {
            values.removeLast(count)
        }
        
        return Array(values[(values.count - count)...])
    }
    
    public mutating func duplicate() throws {
        guard let value = values.last else {
            throw InsufficientNumberOfOperandsError()
        }
        
        values.append(value)
    }
    
    public mutating func swap() throws {
        guard values.count >= 2 else {
            throw InsufficientNumberOfOperandsError()
        }
        
        values.swapAt(values.count - 1, values.count - 2)
    }
    
    public mutating func over() throws {
        guard values.count >= 2 else {
            throw InsufficientNumberOfOperandsError()
        }
        
        values.append(values[values.count - 2])
    }
    
    public mutating func rotate() throws {
        guard values.count >= 3 else {
            throw InsufficientNumberOfOperandsError()
        }
        
        values.swapAt(values.count - 1, values.count - 2)
        values.swapAt(values.count - 1, values.count - 3)
    }
}

extension RequiemRegister {
    public struct InsufficientNumberOfOperandsError: Error {}
}
