# Testing in a OOP Settings

## Principles of OOP
Modern software development paradigm leverage the concept of objects to hide implementation details behind some abstractions. 

To make an example, let's consider an address book. When we write a new address in the address book in the real life, we simply write or type the address into it. We don't care whether it is written on paper or if it is digital. Adding the address is the operation we perform on the address book.

Translating this example in the programming world, we need a data structure with some operation. That's an object.
The object exposes the typical operations we can do, like adding the address, but we don't care whther its using a dictionary or an array. We only care that we can do some operations.

## Testing OOP
In the previous chapter, we understood what is a pure function and how we can test it. To test a pure function, we provide some inputs and we compare the output of the function with the expected result.

When we move this testing principle in the Object oriented world, nothing changes. We still have to provide some input and to check some output. The difference, now, is that inputs and outputs can be stored within the object. In other words, they are implicit.

### Implicit Outputs
Imagine that we have to test addAdddress feature of the address book. First of all, we need our object:

```swift
struct  Address {
	let street: String
	let number: Int
	let zipCode: String
}

class AddressBook {
	var storage: [String: Address]

	func add(address: Address, for owner: String) {
		self.storage[owner] = address
	}
}
```

The `Address` struct is a plain data model to store the essential informations of an address. The Addreess book allows us to save an address using the `add(address:for:)` method. 

Observe that the `add(address:for:)` does not have any return parameter. How can we test it? How can we compare the actual output with the expected output?

In this example, the output is **implicit** and it is the state of the `AddressBook`. A test to verify that the `add` function work properly is to check whether the storage actually contains what we added.

```swift
import XCTest
@testable import AddressBook

class AddressBookTests: XCTestCase {
	func testAdd_InsertAddress() {
		// Arrange
		let addressBook = AddressBook()
		let owner = "test"
		let address = Address(street: "test street", number: 1, zipCode: "TST")

		// Act
		addressBook.add(address: address, for: owner)

		// Assert
		XCTAssertEqual(addressBook.storage[owner]!, address)
	}
}

```

This test is split in the standard phases: Arrange, Act, Assert. 

* In the Arrange step, we prepare the AddressBook, the Address and the owner.
* In the Act step, we run the `add` method.
* In the Assert step, we check whether the storage actually contains the added item.

If you run this code, you'll notice that it doesn't build. This because `XCTAssertEqual` requires that `Address` conforms to `Equatable`. Let's add this conformance in the `AddressBook.swift` file.

```swift
extension Address: Equatable {}
```

The `Equatable` conformance is something common when working with objects, especially if we need to compare two data structures to check whether they represents the same object.

## Implicit Input
We already tested the behavior of the `add` method. However, in the test, we are directly accessing the `storage` variable to see whether the add method worked properly. We are accessing the data structure that is actually keeping that information, but this means that we can't change that detail freely. In fact, if we decide to save the pairs of owner and address in an array, for example, we should update the test accordingly.

This version couples the `AddressBook`'s implementation details with the tests. It exposes how the `AddressBook` is implemented, and this violates the encapsulation, but we don't want that.

To fix this problem, we can implement a `getAddress(for:)` method to retrieve an address given a specific owner.

```swift
class AddressBook {
	// ...

	func getAddress(for owner: String) -> Address? {
		return self.storage[owner]
	}
}
```

With this method, we are passing an owner and we want to check whether there is an associated address. If we look at the method signature, it only takes a `String`, the owner. Where will it search for the presence of the address? The answer is in the `storage`. 

The `storage` is an **implicit** input for the `getAddress(for:)` method.

Now, we want to write a test for the `getAddress` method. In the first chapter, we understood that we have to check all the possible execution paths of our code, by creating a test for all the inputs that can lead to a different result. By looking at the method signature, we know that the `getAddress` returns an `Optional<Address>`. This means that we need to write at least two tests:

1. When there is no address and we expect `nil`.
2. When there is the address we are looking for and we expect to obtain exactly that address.

Let's write them:

```swift 

class AddressBookTests: XCTestCase {

	func testAdd_InsertAddress() {
		// Arrange
		let addressBook = AddressBook()
		let owner = "test"
		let address = Address(street: "test street", number: 1, zipCode: "TST")

		// Act
		addressBook.add(address: address, for: owner)

		// Assert
		XCTAssertEqual(addressBook.storage[owner]!, address)
	}

	// MARK: - New tests

	func testGetAddress_whenThereIsNoAddress_returnsNil() {
		// Arrange
		let addressBook = AddressBook()
		let owner = "test owner"

		// Act
		let address = addressBook.getAddress(for: owner)

		// Assert
		XCTAssertNil(address)
	}

	func testGetAddress_whentThereIsAddress_returnsTheAddress() {
		// Arrange
		let addressBook = AddressBook()
		let owner = "test"
		let address = Address(street: "test street", number: 1, zipCode: "TST")
		addressBook.add(address: address, for: owner)

		// Act
		let retrievedAddress = addressBook.getAddress(for: owner)

		// Assert
		XCTAssertEqual(retrievedAddress, address)
	}
}
```

We addedd two tests, after the `MARK` comment. The first one prepares a new addressBook and tries to retrieve the address associated with the `"test owner"` owner. We use the `XCTAssertNil` method to ensure that the returned address is `nil`.
The latter test prepares the same objects as the `testAdd_InsertAddress` and then acts by getting the address. We compare the `retrievedAddress` with the address prepared during the arrange part. In some case, we refer to that object as the expected value or, in this specific case, the `expectedAddress`.


### Testing Errors.
Also in OOP, we leverage the same principles we explored in testing functions: in this case, by adding a test for the `nil` return value and a test for the actual value, we are covering all the possible outcomes for our code, thus we are maximizing the code coverage.

Following this principle, we also would like to test eventual errors, when they happen. Let's consider tha case where we add an address for an owner and we try to add a different address for the same owner. A simple approach could be to throw an excpetion to let the user know that we already have an address.

To do so, we need to update the `AddressBook` code as it follows:

```swift 

class AddressBook {
	struct AddressAlreadyExists: Error {}

	// storage

	func add(address: Address, for owner: String) throws {
		guard self.storage[owner] == nil else {
			throw AddressAlreadyExists()
		} 

		self.storage[owner] = address
	}

	// get
}

``` 

This force us to update the tests as well.

```swift
class AddressBookTests: XCTestCase {	
	func testAdd_InsertAddress() throws {
		// Arrange
		let addressBook = AddressBook()
		let owner = "test"
		let address = Address(street: "test street", number: 1, zipCode: "TST")

		// Act
		try addressBook.add(address: address, for: owner)

		// Assert
		XCTAssertEqual(addressBook.storage[owner]!, address)
	}

	// MARK: - New tests

	// testGetAddress_whenThereIsNoAddress_returnsNil does not changes


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
```

The changes are simple here:

1. add the `throws` keyword after the test methods.
2. add the `try` keywork before the `add` method invocation.

Thanks to the first change, if the test method throws, XCTest won't interrupt the test suite but it will record the test as failing, marking the location where the test actually failed. This gives us a cue we can use to fix a bug or to understand what's going wrong.

Now, it's time to write a test to check that the exception is actually raised. Notice that we already have a test to check that the `add` method works. However, after the previous change, one path of the `add` is not covered by tests.

```swift
class AddressBookTests: XCTestCase {	
	// ... other tests ...
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

```  

In this test, the arrange step consists in preparing the address book with an `address` that we will try to add again.
The act and the assert steps happen together: the second `add` invocation triggers the exception. We want to assert that the exception is raised, using the `XCTAssertThrowsError` and that the error is of the right type, in this case an `AddressAlreadyExists` error.

### Visibility Modifier
At the beginning of this chapter, we talked about encapsulation. Encapsulation let us protect the internal details of our objects from the outer world. In this way, we can update and change the internal implementation of the object without the need to change how it is used.

Swift gives us 4 accessor modifiers:

* `public`: the property or method can be used everywhere
* `internal`: the property or method can be used everywhere within the module where it is defined. The `internal` modifier is the default, we don't have to specify it.
* `fileprivate`: the property or method can be used freely within the swift file where it is defined.
* `private`: the property or method can be used freely within the datatype (struct/class/actor/enum) where it is defined.

In our case, we want to protect the access to the `storage`. Noone but the `AddressBook` should be able to manipulate it. In that way, if in the future we would like to change the implementation with a tuple list or another data structure, we could do it without bothering the user of the `AddressBook`. Let's change the code as it follows:

```swift
class AddressBook {
	// error
	private var storage: [String: Address]

	// methods

}
```

As you can see, we added the `private` modifier before the `storage` var. If we now tries to run the tests, they broke. In fact, the `testAdd_InsertAddress()` method is still accessing the `storage` property directly. We can update that by changing the assert line:

```swift
class AddressBookTests: XCTestCase {	
	func testAdd_InsertAddress() throws {
		// Arrange
		let addressBook = AddressBook()
		let owner = "test"
		let address = Address(street: "test street", number: 1, zipCode: "TST")

		// Act
		try addressBook.add(address: address, for: owner)

		// Assert
		XCTAssertEqual(addressBook.getAddress(for: owner), address)
	}
	// other tests
}
```

Now it work. But the this test looks extremely similar to the `testGetAddress_whentThereIsAddress_returnsTheAddress()`: the only difference is in how the test is structured with respect to the `Act` and `Assert` steps. We can remove one of the two tests, given that they are identical.

A question may rise here: does removing a test weaken the power of the test suite? The answer is: it depends. In this case, no: the use case of the address book is to set addresses so that we can retrieve them afterward. The simple `add` alone won't do any good without the corresponding `get`, so it's ok that we test the two together. What we want to achieve is that, after we added an address, we are able to retrieve it and the tests ensure that.

However, there are cases when we have objects whose the only purpose is to add elements to some sort of storage. We will see in the next chapter how these can be tested. 

**Note:** The test target and the app/framework target are two different modules, therefore the test target cannot normally access the internal implementations of the module we want to test. Usually, we want to test only public interfaces of our objects, which is the surface that can be used from other components. However, when a module begins to grow and becomes more complex, we need to test internal details of the module. The `@testable` annotation before the `import AddressBook` makes the `internal` details available to the test target. The `private` and `fileprivate` details, instead, stays unavailable and they shouldn't be tested. Testing `private` details couples the code with the test and hinder our refactor possibilities. 

### Defensive Testing
The last topic about testing in this context is defensive testing. This practice consists in adding some assertions before the `Act` step to verify that the state of the system is the right one before we try to modify it.

Let's take the `testAdd_InsertAddress()` method, for instance. Imagine that the `AddressBook` 's `getAddress` method always returns that address when invoked. Something like this:

```swift
class AddressBook {
	func getAddress(for owner: String) -> Address? {
		return Address(street: "test street", number: 1, zipCode: "TST")
	}

}
```
The test will always pass even if the method is doing the wrong thing. So, let's add an assertion to try and avoid this possibility. To do so, we can improve the `testAdd_InsertAddress()` method as it follows:

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
	// other tests
}


By adding the `XCTAssertNil(addressBook.getAddress(for: owner))` line, we are checking that, before inserting the address in the `AddressBook`, the `getAddress` method must return `nil`.

Of course, a malicious developer could workaround this check by adding a counter and returning `nil` at the first invocation and then the proper addres after the first. We can't of course increasingly add multiple `XCTAssertNil` calls. 
Another thing we can do is to create another test to add another, different address and to retrieve it. We can choose whether we want to add those few lines in the same `testAdd_InsertAddress` or if we want a completely different test. In this case, let's create a new test.

class AddressBookTests: XCTestCase {	
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
	// other tests
}

And now we are pretty sure that the add and retrieve methods has to work properly.

## Exercise
For this chapter, we have prepared a framework called `TemperatureStation`. We implemented an object called `TemperatureStation` and a data structure called `TemperatureMeasurement`.

As first thing, spend some minutes reading the documentation of the `TemperatureStation` object. Then, start implementing the tasks in the `TemperatureStationTests` target. Remember to open a PR for each task.

### Task 1
Write all the tests for the `temperatures(for:)` method. 

How many tests do you need?

### Task 2
Write all the tests for the `append(measurement:)` method, the `internal` one.

How many tests do you need?

### Task 3
Write all the tests for the `mostRecentMeasurement(for:)` method.

How many tests do you need?

### Task 4
Write all the tests for the `cities` properties.

How many tests do you need?

### Task 5
Write all the tests for the `city24HAverage` properties.

How many tests do you need?

### Task 6
Write all the tests for the `insert(measurement:)` method.

How many tests do you need?


