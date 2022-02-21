import XCTest
@testable import Calculator

extension CalculatorTests {
  
  func testAverage_whenArrayOfNumbers_returnsValue() throws {
    let values = [3,5,7]
    
    let result = Calculator.average(values)
    
    XCTAssertEqual(result, 5)
  }
  
  func testAverage_whenEmptyArray_returnsNil() throws {
    let values : [Int] = []
    
    let result = Calculator.average(values)
    
    XCTAssertEqual(result, nil)
  }
}
