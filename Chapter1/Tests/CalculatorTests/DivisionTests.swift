import XCTest
@testable import Calculator

extension CalculatorTests {
  func testDivision_whenDividingBySameNumber_returnsOne() throws {
    let first = 5
    let second = 5
    
    let result = try Calculator.division(first, second)
    
    XCTAssertEqual(result, 1)
  }
  
  func testDivision_whenDividingByZero_returnsNil() throws {
    let first = 3
    let second = 0
    
    let result = try? Calculator.division(first, second)
    
    XCTAssertEqual(result, nil)
  }
}
