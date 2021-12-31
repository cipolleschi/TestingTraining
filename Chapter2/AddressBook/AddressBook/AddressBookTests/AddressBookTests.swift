//
//  AddressBookTests.swift
//  AddressBookTests
//
//  Created by Riccardo Cipolleschi on 30/12/21.
//

import XCTest
@testable import AddressBook

class AddressBookTests: XCTestCase {
  
  func testAdd_InsertAddress() throws {
    // Arrange
    let addressBook = AddressBook()
    let owner = "test"
    let address = Address(street: "test street", number: 1, zipCode: "TST")
    
    // Defensive check: assert the state of the system
    XCTAssertNil(addressBook.getAddress(for: owner))
    
    // Act
    try addressBook.add(address: address, for: owner)
    
    // Assert
    XCTAssertEqual(addressBook.getAddress(for: owner), address)
  }
  
  func testAdd_whenAddressAlreadyExists_throws() throws {
    // Arrange
    let addressBook = AddressBook()
    let owner = "test"
    let address = Address(street: "test street", number: 1, zipCode: "TST")
    try addressBook.add(address: address, for: owner)
    
    // Act
    // Assert
    XCTAssertThrowsError(try addressBook.add(address: address, for: owner)) { error in
      XCTAssertTrue(error is AddressBook.AddressAlreadyExists)
    }
  }
  
  func testAdd_multipleAddresses_canRetrieveThem() throws {
      // Arrange
      let addressBook = AddressBook()
      let owner1 = "test"
      let address1 = Address(street: "test street", number: 1, zipCode: "TST")

      let owner2 = "test2"
      let address2 = Address(street: "test street2", number: 3, zipCode: "TSX")

      // Defensive check: assert the state of the system
      XCTAssertNil(addressBook.getAddress(for: owner1))
      XCTAssertNil(addressBook.getAddress(for: owner2))

      // Act
      try addressBook.add(address: address1, for: owner1)
      try addressBook.add(address: address2, for: owner2)

      // Assert
      XCTAssertEqual(addressBook.getAddress(for: owner1), address1)
      XCTAssertEqual(addressBook.getAddress(for: owner2), address2)
    }
  
  func testGetAddress_whenThereIsNoAddress_returnsNil() {
    // Arrange
    let addressBook = AddressBook()
    let owner = "test owner"
    
    // Act
    let address = addressBook.getAddress(for: owner)
    
    // Assert
    XCTAssertNil(address)
  }
  
  func testGetAddress_whentThereIsAddress_returnsTheAddress() throws {
    // Arrange
    let addressBook = AddressBook()
    let owner = "test"
    let address = Address(street: "test street", number: 1, zipCode: "TST")
    try addressBook.add(address: address, for: owner)
    
    // Act
    let retrievedAddress = addressBook.getAddress(for: owner)
    
    // Assert
    XCTAssertEqual(retrievedAddress, address)
  }
}
