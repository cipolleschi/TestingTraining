import XCTest
@testable import Calculator

extension CalculatorTests {
  func testMultiply_whenIdentityProperty_returnsItself() throws {
    // The multiplicative identity is 1; anything multiplied by 1 is itself
    let first = 5
    let second = 1
    
    let result = Calculator.multiply(first, second)
    
    XCTAssertEqual(result, first)
  }
  
  func testMultiply_whenZeroProperty_returnsZero() throws {
    // Any number multiplied by 0 is 0
    let first = 3
    let second = 0
    
    let result = Calculator.multiply(first, second)
    
    XCTAssertEqual(result, 0)
  }
  
  func testMultiply_twoMultipliedByThreeAndThreeMultipliedByTwo_returnsTheSameResult() throws {
    // commutative property: a * b = b * a
    let first = 2
    let second = 3
    
    let result1 = Calculator.multiply(first, second)
    let result2 = Calculator.multiply(second, first)
    
    XCTAssertEqual(result1, result2)
  }
  
  func testMultiply_twoMultipliedByThree_MultipliedByFour_AndTwoMultipliedBy_ThreeMultipliedByFour_returnsTheSameResult() throws {
    // associative property: (a * b) * c = a * (b * c)
    let first = 5
    let second = 19
    let third = 54
    
    let result1 = Calculator.multiply(Calculator.multiply(first, second), third)
    let result2 = Calculator.multiply(first, Calculator.multiply(second, third))
    
    XCTAssertEqual(result1, result2)
  }
  
  func testMultiply_withNegativeProperty() throws {
    let first = 4
    let second = -5
    
    let result = Calculator.multiply(first, second)
    
    XCTAssertEqual(result, -20)
  }
  
  func testMultiply_withNegativeProperties() throws {
    let first = -7
    let second = -10
    
    let result = Calculator.multiply(first, second)
    
    XCTAssertEqual(result, 70)
  }
}
