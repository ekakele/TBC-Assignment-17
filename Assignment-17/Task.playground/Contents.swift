//  Assignment-17
//
//  Created by Eka Kelenjeridze on 08.11.23.
//

import Foundation

//MARK: - Properties
private let group = DispatchGroup()
private var winnerIsDetected: Bool = false

//MARK: - Functions
private func generateRandomInt(min: Int, max: Int) -> Int {
    let randomInt = Int.random(in: min...max)
    return randomInt
}

private func multiplyAndHandleCarryovers(_ digits: [Int], by multiplier: Int) -> [Int] {
    var result = [Int]()
    
    var carry = 0
    for digit in digits.reversed() {
        let product = digit * multiplier + carry
        let newDigit = product % 10
        carry = product / 10
        result.append(newDigit)
    }
    
    while carry > 0 {
        let newDigit = carry % 10
        carry = carry / 10
        result.append(newDigit)
    }
    return result.reversed()
}

private func calculateFactorial(number: Int) -> String {
    var resultDigits = [1]
    for currentFactor in 2...number {
        resultDigits = multiplyAndHandleCarryovers(resultDigits, by: currentFactor)
    }
    
    let result = resultDigits.map(String.init).joined()
    
    return result
}

private func asynchronousFactorialCalculatorOne(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
        let randomNumber = generateRandomInt(min: 20, max: 50)
        let result = calculateFactorial(number: randomNumber)
        if winnerIsDetected == false {
            printResultText(winner: true, threadNumber: 1, number: randomNumber, factorial: result)
            
            winnerIsDetected = true
        } else {
            printResultText(winner: false, threadNumber: 1, number: randomNumber, factorial: result)
        }
        
        completion()
    }
}

private func asynchronousFactorialCalculatorTwo(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
        let randomNumber = generateRandomInt(min: 20, max: 50)
        let result = calculateFactorial(number: randomNumber)
        if winnerIsDetected == false {
            printResultText(winner: true, threadNumber: 2, number: randomNumber, factorial: result)
            
            winnerIsDetected = true
        } else {
            printResultText(winner: false, threadNumber: 2, number: randomNumber, factorial: result)
        }
        completion()
    }
}

private func printResultText(winner: Bool, threadNumber: Int, number: Int, factorial: String) -> Void {
    if winner {
        print("🏆 The winner thread is function #\(threadNumber). \n The factorial of the integer \(number) is \(factorial).")
    } else {
        print("⛔️ The loser thread is function #\(threadNumber). \n The factorial of the integer \(number) is \(factorial).")
    }
}

asynchronousFactorialCalculatorOne {
    print("\n")
}
asynchronousFactorialCalculatorTwo {
    print("\n")
}

print("Conclusion: the bigger the result number the longer it takes to complete calculation.")

