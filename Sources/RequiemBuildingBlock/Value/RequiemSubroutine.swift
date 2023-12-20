
public final class RequiemSubroutine: RequiemObject {
    public let arity: UInt8
    public let storageSize: UInt8
    public let bytecodes: [UInt8]
    public let strings: [String]
    
    public init(arity: UInt8, storageSize: UInt8, bytecodes: [UInt8], strings: [String]) {
        self.arity = arity
        self.storageSize = storageSize
        self.bytecodes = bytecodes
        self.strings = strings
    }
}
