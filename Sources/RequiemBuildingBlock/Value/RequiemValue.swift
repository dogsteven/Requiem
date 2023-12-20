
public enum RequiemValue {
    case null
    case boolean(value: Bool)
    case integer(value: Int)
    case real(value: Double)
    case string(value: String)
    case result(value: RequiemResultValue)
}

public indirect enum RequiemResultValue {
    case success(value: RequiemValue)
    case error(value: RequiemValue)
}
