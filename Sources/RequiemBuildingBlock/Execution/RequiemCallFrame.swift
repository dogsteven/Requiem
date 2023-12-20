
public final class RequiemCallFrame {
    public let subroutine: RequiemSubroutine
    internal var ip: Int
    internal var storage: RequiemStorage
    
    public init(subroutine: RequiemSubroutine) {
        self.subroutine = subroutine
        self.ip = 0
        self.storage = RequiemStorage(size: subroutine.storageSize)
    }
}
