//
//  main.swift
//  ExtDomainModel
//
//  Created by Yichao Wang on 4/12/17.
//  Copyright © 2017 Yichao Wang. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

protocol CustomStringConvertible {
    var description: String {get}
}

protocol Mathematics {
     func add(_ to: Money) -> Money
     func subtract(_ from: Money) -> Money
}



////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible, Mathematics {
  public var amount : Int
  public var currency : String
  
  var description: String {
    return "\(currency)\(amount)"
  }
  
  public func convert(_ to: String) -> Money {
    let rate = ["GBP": 0.5, "EUR": 1.5, "CAN": 1.25, "USD": 1.0]
    if self.currency == "USD" {
        return Money(amount: Int(Double(self.amount) * rate[to]!), currency: to)
        
    } else {
        if to == "USD" {
            return Money(amount: Int(Double(self.amount) / rate[self.currency]!), currency: to)
        }
        return Money(amount: Int(Double(self.amount) / rate[self.currency]! * rate[to]!), currency: to)
    }
  }
  
  public func add(_ to: Money) -> Money {
    let exchange = self.convert(to.currency)
    return Money(amount: exchange.amount + to.amount, currency: to.currency)
  }
  
  public func subtract(_ from: Money) -> Money {
    let exchange = self.convert(from.currency)
    return Money(amount: exchange.amount - from.amount, currency: from.currency)
  }
}

extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    
    var YEN: Money {
        return Money(amount: Int(self), currency: "YEN")
    
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
  fileprivate var title : String
  fileprivate var type : JobType

  var description: String {
    return "\(title), \(type)"
  }
  
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
        case .Hourly(let money):
            return Int(Double(hours) * money)
        case .Salary(let money):
            return money
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
        case .Hourly(let money):
            type = JobType.Hourly(money + amt)
        case .Salary(let money):
            type = JobType.Salary(Int(Double(money) + amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0


  
  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
        return _job
    }
    set(value) {
        if self.age >= 16 {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
        return _spouse
    }
    
    set(value) {
        if self.age >= 18 {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
  }
  
  var description: String {
    var jobdes = ""
    var spousedes = ""
    if (job == nil) {
        jobdes = "nil"
    } else {
        jobdes = job!.description
    }
    
    if (spouse == nil) {
        spousedes = "nil"
    } else {
        spousedes = "\(spouse!.firstName) \(spouse!.lastName)"
    }
    
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(jobdes) spouse:\(spousedes)]"
  }
}

////////////////////////////////////
// Famil!y
//
open class Family: CustomStringConvertible {
  fileprivate var members : [Person] = []
  
  var description: String {
    var result = ""
    for member in members {
        result += member.description + " "
    }
    return result
  }
  public init(spouse1: Person, spouse2: Person) {
    if spouse1._spouse == nil && spouse2._spouse == nil && spouse1.age >= 21 || spouse2.age >= 21{
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members.append(spouse1)
        self.members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    child.age = 0
    members.append(child)
    return true
  }
  
  open func householdIncome() -> Int {
    var result = 0
    for person in members {
        if person._job != nil {
            result += person._job!.calculateIncome(2000)
        }
    }
    return result
  }
}

