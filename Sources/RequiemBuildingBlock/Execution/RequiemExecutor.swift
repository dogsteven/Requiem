import Collections

@available(macOS 10.15.0, *)
public actor RequiemExecutor {
    private let environment: RequiemEnvironment
    private let fetcher: RequiemInstructionFetcher
    
    private var isRunning: Bool
    private var queue: Deque<RequiemExecutionContext>
    
    public init(environment: RequiemEnvironment, fetcher: RequiemInstructionFetcher) {
        self.environment = environment
        self.fetcher = fetcher
        
        self.isRunning = false
        self.queue = []
    }
    
    public func start() async {
        guard !isRunning else {
            return
        }
        
        while isRunning {
            guard let context = queue.popFirst() else {
                await Task.yield()
                continue
            }
            
            let result = execute(context: context)
            print(result)
            
            await Task.yield()
        }
    }
    
    public func stop() {
        isRunning = false
    }
    
    internal func execute(context: RequiemExecutionContext) -> RequiemExecutionResult {
        contextExecutionLoop: while let frame = context.topFrame() {
            frameExecutionLoop: while true {
                do {
                    let (instruction, consumed) = try fetcher.fetch(subroutine: frame.subroutine, ip: frame.ip)
                    
                    frame.ip += consumed
                    
                    guard let instruction else {
                        break frameExecutionLoop
                    }
                    
                    switch instruction.act(register: &context.register, storage: &frame.storage, environment: environment) {
                    case .continue:
                        continue frameExecutionLoop
                        
                    case .jump(let offset):
                        frame.ip += offset
                        continue frameExecutionLoop
                        
                    case .yieldSubroutine(let subroutine):
                        context.pushFrame(RequiemCallFrame(subroutine: subroutine))
                        continue contextExecutionLoop
                        
                    case .return:
                        context.popFrame()
                        continue contextExecutionLoop
                        
                    case .halt:
                        isRunning = true
                        return .success
                        
                    case .error(let error):
                        return .error(error)
                    }
                } catch {
                    return .error(error)
                }
            }
            
            context.popFrame()
        }
        
        return .success
    }
}

public enum RequiemExecutionResult {
    case success
    case error(Error)
}
