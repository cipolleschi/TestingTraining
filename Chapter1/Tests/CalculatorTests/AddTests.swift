import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
  func testAdd_whenOnePlusOne_returnsTwo() throws {
    let first = 1
    let second = 1
    
    let result = Calculator.add(first, second)
    
    XCTAssertEqual(result, 2)
  }
  
  func testAdd_whenFirstIsZero_returnsSecond() throws {
    // neutral element: 0 + x = x
    let first = 0
    let second = 5
    
    let result = Calculator.add(first, second)
    
    XCTAssertEqual(result, 5)
  }
  
  func testAdd_whenSecondIsZero_returnsFirst() throws {
    // neutral element: x + 0 = x
    let first = 3
    let second = 0
    
    let result = Calculator.add(first, second)
    
    XCTAssertEqual(result, 3)
  }
  
  func testAdd_twoPlusThreeAndThreePlusTwo_returnsTheSameResult() throws {
    // commutative property: a + b = b + a
    let first = 4
    let second = 6
    
    let result1 = Calculator.add(first, second)
    let result2 = Calculator.add(second, first)
    
    XCTAssertEqual(result1, result2)
  }
  
  func testAdd_twoPlusThree_PlusFour_AndTwoPlus_ThreePlusFour_returnsTheSameResult() throws {
    // associative property: (a+b)+c = a+(b+c)
    let first = 2
    let second = 3
    let third = 4
    
    let result1 = Calculator.add(Calculator.add(first, second), third)
    let result2 = Calculator.add(first, Calculator.add(second, third))
    
    XCTAssertEqual(result1, result2)
  }
}
