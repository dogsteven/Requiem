
public final class RequiemExecutionContext {
    private var frames: [RequiemCallFrame]
    internal var register: RequiemRegister
    
    public init(frames: [RequiemCallFrame], register: consuming RequiemRegister) {
        self.frames = frames
        self.register = register
    }
    
    public func topFrame() -> RequiemCallFrame? { frames.last }
    
    @discardableResult
    public func popFrame() -> RequiemCallFrame? { frames.popLast() }
    
    public func pushFrame(_ frame: RequiemCallFrame) { frames.append(frame) }
}
