//
//  ExtDomainModelTests.swift
//  ExtDomainModelTests
//
//  Created by Yichao Wang on 4/12/17.
//  Copyright © 2017 Yichao Wang. All rights reserved.
//

import XCTest

class ExtDomainModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCustomStringConvertible() {
        let tenUSD = Money(amount: 10, currency:"USD")
        XCTAssert(tenUSD.description == "USD10")
        
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer, Salary(1000)")
        let job2 = Job(title: "Guest Lecturer", type: Job.JobType.Hourly(1000))
        XCTAssert(job2.description == "Guest Lecturer, Hourly(1000.0)")

        let max = Person(firstName: "Max", lastName: "Lee", age: 33)
        XCTAssert(max.description == "[Person: firstName:Max lastName:Lee age:33 job:nil spouse:nil]")
        max.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(max.description == "[Person: firstName:Max lastName:Lee age:33 job:Guest Lecturer, Salary(1000) spouse:nil]")
        

        let alice = Person(firstName: "Alice", lastName: "Lee", age: 33)
        let family = Family(spouse1: max, spouse2: alice)
        print(family.description)
        XCTAssert(family.description == "[Person: firstName:Max lastName:Lee age:33 job:Guest Lecturer, Salary(1000) spouse:Alice Lee] [Person: firstName:Alice lastName:Lee age:33 job:nil spouse:Max Lee] ")
    }
    
    func testMathematics() {
        let tenUSD = Money(amount: 10, currency:"USD")
        let oneUSD = Money(amount: 1, currency:"USD")
        let test1 = tenUSD.add(oneUSD)
        XCTAssert(test1.amount == 11 && test1.currency == "USD")
        
        let test2 = tenUSD.subtract(oneUSD)
        XCTAssert(test2.amount == 9 && test2.currency == "USD")
        
        let oneGBP = Money(amount: 10, currency:"GBP")
        let test3 = oneGBP.add(tenUSD)
        XCTAssert(test3.amount == 30 && test3.currency == "USD")
    }
    
    func testExtention() {
        XCTAssert(10.USD.amount == 10)
        XCTAssert(100.USD.description == "USD100")
        XCTAssert(60.YEN.description == "YEN60")
        XCTAssert(55.EUR.amount == 55 && 55.EUR.currency == "EUR")

    }
    

    
}
