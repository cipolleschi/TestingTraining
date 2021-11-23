# Testing Training
The purpose of this repository is to help people learn the basics of testing in Swift.
 I decided to prepare this repository because many people reached out to ask for advice and guidance on testing their code. I think that this is the fastest way to help as many people as I can.

The idea is to read the theory and the examples in the repository, execute the exercises and ask for a code review. See the [How To Work With This Repository](#how-to-work-with-this-repositoy) section to know how to request help.
 
 ## Content
 
 Most of the concepts discussed here can be applied to many other programming languages, although you'll need to use the proper technology to apply them. For example, you will need to use [JUnit](https://junit.org/junit5/) specific `assertEquals` instead of `XCAssertEquals` from `XCTest`. This makes this knowledge valuable, independently from your experience.
 
 The repository is organized into chapters. We will start with the basics and with the tools. Moving on, we will analyze more complex problems, understanding how we can test them.
 For every chapter, I'll try to explain the theory, provide some examples and leave some exercises to work with the concepts.
 
 ### Summary
 1. Basics and Pure Functions
 2. Tesing in An OOP Settings
 3. Working with Dependencies
 4. Avoiding Expectations in Tests 
 5. Test Driven Development
 6. Snapshot Testing
 7. Basics of UITesting
 
 ## Prerequisites
The requisites to fully profit from this repository are:

* Xcode. We will use Xcode 13.2 when developing the examples and exercises.
* a basic knowledge of Swift. We won't use super-advanced tricks, but you need to be comfortable with protocols and closures.

## How to Work With This Repository
To request a review, you can follow this process:

1. Fork this repository in your Github.
2. Invite me to the repository (@cipolleshi).
3. Choose a chapter you want to exercise with.
4. Create a branch. 
5. Execute the exercises.
6. Open a PR from your development branch to your `main` branch
7. Wait for my review. I usually receive the Github notification in the email, so I should be notified when there is a change. If I haven't reviewed the PR after one week, feel free to send me an email.

I hope this can help all of you improve your testing skills and, together with them, your software engineering skills.
