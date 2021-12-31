//
//  AddressBook.swift
//  AddressBook
//
//  Created by Riccardo Cipolleschi on 30/12/21.
//

import Foundation

struct Address {
  let street: String
  let number: Int
  let zipCode: String
}

class AddressBook {
  struct AddressAlreadyExists: Error {}
  
  private var storage: [String: Address] = [:]

  func add(address: Address, for owner: String) throws {
      guard self.storage[owner] == nil else {
        throw AddressAlreadyExists()
      }

      self.storage[owner] = address
    }
  
  func getAddress(for owner: String) -> Address? {
    return self.storage[owner]
  }
}

extension Address: Equatable {}
