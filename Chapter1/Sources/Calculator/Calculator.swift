public enum Calculator {
    enum CalculatorError: Error {
        case divisionByZero
    }
    
    public static func add(_ first: Int, _ second: Int) -> Int {
        return first + second
    }
    
    public static func subtract(_ first: Int, _ second: Int) -> Int {
        return first - second
    }
    
    public static func multiply(_ first: Int, _ second: Int) -> Int {
        return first * second
    }
    
    public static func division(_ first: Int, _ second: Int) throws -> Int {
        guard second != 0 else {
            throw CalculatorError.divisionByZero
        }
        
        return first / second
    }
    
    public static func average(_ values: [Int]) -> Double? {
        guard !values.isEmpty else {
            return nil
        }
        return Double(values.reduce(0, +)) / Double(values.count)
    }
    
    public static func modulus(_ value: Int) -> Int {
        return value < 0 ? -value : value
    }
}
