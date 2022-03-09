import XCTest
@testable import Calculator

extension CalculatorTests {
  
  func testModulus_whenPositiveNumber_returnsItself() throws {
    let value = 5
    
    let result = Calculator.modulus(value)
    
    XCTAssertEqual(result, 5)
  }
  
  func testModulus_whenNegativeNumber_returnsAbsoluteValue() throws {
    let value = -5
    
    let result = Calculator.modulus(value)
    
    XCTAssertEqual(result, 5)
  }
  
  func testModulus_whenZero_returnsZero() throws {
    let value = 0
    
    let result = Calculator.modulus(value)
    
    XCTAssertEqual(result, 0)
  }
}
