import XCTest
@testable import Calculator

extension CalculatorTests {
  
  func testSubtract_whenTwoMinusOne_returnsOne() throws {
    let first = 2
    let second = 1
    
    let result = Calculator.subtract(first, second)
    
    XCTAssertEqual(result, 1)
  }
  
  func testSubtract_whenFirstIsZero_returnsNegativeSecond() throws {
    // neutral element: 0 - x = -x
    let first = 0
    let second = -5
    
    let result = Calculator.subtract(first, second)
    
    XCTAssertEqual(result, 5)
  }
  
  func testSubtract_whenSecondIsZero_returnsFirst() throws {
    // neutral element: x - 0 = x
    let first = 3
    let second = 0
    
    let result = Calculator.subtract(first, second)
    
    XCTAssertEqual(result, 3)
  }
  
  func testSubtract_twoMinusThreeAndThreeMinusTwo_returnsTheOppositeResult() throws {
    // anti-commutative property: a - b = -(b - a)
    let first = 2
    let second = 3
    
    let result1 = Calculator.subtract(first, second)
    let result2 = Calculator.subtract(second, first)
    
    XCTAssertEqual(result1, -result2)
  }
}
