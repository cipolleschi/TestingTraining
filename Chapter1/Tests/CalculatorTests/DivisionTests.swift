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
    var thrownError: Error?
    let first = 3
    let second = 0
        
    XCTAssertThrowsError(try Calculator.division(first, second)) {
      thrownError = $0
    }
    XCTAssertTrue(thrownError is Calculator.CalculatorError)
    XCTAssertEqual(thrownError as? Calculator.CalculatorError, .divisionByZero)
  }
  
  func testDivision_whenNumeratorIsZero() throws {
    let first = 0
    let second = 5
    
    let result = try Calculator.division(first, second)
    
    XCTAssertEqual(result, first)
  }
  
  func testDivision_whenDividingByOne() throws {
    let first = 11
    let second = 1
    
    let result = try Calculator.division(first, second)

    XCTAssertEqual(result, first)
  }
  
  func testDivision_whenDividingByNegativeValue() throws {
    let first = 6
    let second = -2
    
    let result = try Calculator.division(first, second)
    
    XCTAssertEqual(result, -3)
  }
  
  func testDivision_whenBothValuesAreNegative() throws {
    let first = -4
    let second = -2
    
    let result = try Calculator.division(first, second)

    XCTAssertEqual(result, 2)
  }
  
  func testDivision_forNonIntegerDivision() throws {
    let first = 5
    let second = 2
    
    let result = try Calculator.division(first, second)

    XCTAssertEqual(result, 2)
  }
}
