
public protocol RequiemInstructionFetcher {
    func fetch(subroutine: RequiemSubroutine, ip: Int) throws -> (instruction: RequiemInstruction?, consumed: Int)
}
