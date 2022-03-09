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
  
  func testAverage_whenArrayHasSingleValue() throws {
    let values = [42]
    
    let result = Calculator.average(values)
    
    XCTAssertEqual(result, Double(values[0]))
  }
  
  func testAverage_whenArrayHasSomeNegativeValues() throws {
    let values = [2, -3, 4, -5]
    
    let result = Calculator.average(values)

    XCTAssertEqual(result, -0.5)
  }
  
  func testAverage_whenArrayOnlyHasNegativeValues() throws {
    let values = [-1, -3, -5, -7, -9]
    
    let result = Calculator.average(values)

    XCTAssertEqual(result, -5)
  }
  
  func testAverage_whenAllValuesAreTheSameInArray() throws {
    let values = [9, 9, 9, 9, 9, 9, 9]
    
    let result = Calculator.average(values)

    XCTAssertEqual(result, 9)
  }
}
