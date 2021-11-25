import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    func testAdd_whenOnePlusOne_returnsTwo() throws {
        // Given: This block is used to prepare the data for the test. Sometimes it is also
        // called the Arrange step.
        let first = 1
        let second = 1
        
        // When: This block is used to perform the operation to test. Sometimes it is also called
        // the Act step.
        let result = Calculator.add(first, second)
        
        
        // Then: This block is used to check that the output is what we expect. Sometimes it is also
        // called the Assert step.
        XCTAssertEqual(result, 2)
    }
    
    func testAdd_whenFirstIsZero_returnsSecond() throws {
        // neutral element: 0 + x = x
        
    }
    
    func testAdd_whenSecondIsZero_returnsFirst() throws {
        // neutral element: x + 0 = x
        
    }
    
    func testAdd_twoPlusThreeAndThreePlusTwo_returnsTheSameResult() throws {
        // commutative property: a + b = b + a
        
    }
    
    func testAdd_twoPlusThree_PlusFour_AndTwoPlus_ThreePlusFour_returnsTheSameResult() throws {
        // associative property: (a+b)+c = a+(b+c)
    }
}
