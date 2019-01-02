/*
 The universal product code (UPC) is a bar code used in many parts of the world. The bars encode a 12 digit number used to identify a product for sale for example: 042100005264
 
 The 12th digit (4 in the above case) is a redundant check digit, used to catch errors. Using some simple calculations, a scanner can determine, give the first 11 digits, what the check digit must be for a valid code.
 
 UPC's check digit is calculated as follows:
 
 1. Sum of the digits at odd-numbered positions (1st, 3rd, 5th, ... 10th). If you use 0 based indexing, this is the even-numbered positions (0th, 2nd, 4th, ... 10th)
 
 2. Multiply the result from step one by 3.
 
 3. Take the sum of digits at even-numbered positions (2nd, 4th, 6th, ... 10th) in the original number, and add this sum to the result from step 2.
 
 4. Find the result from step 3 modulo 10 (58 divided by 10 is 5 remainder 8, so M = 8)
 
 5. If M is not 0, subtract M from 10 to get the check digit (10 - M = 10 - 8 = 2)
 
 So the check digit is 2, and the complete UPC is 036000291452.
 
 CHALLENGE:
 
 Given an 11-digit number, find the 12th digit that would make a valid UPC. You may treat the input as a string if you prefer, whatever is more convenient. If you treat it as a number, you may need to consider the case of leading 0's to get up to 11 digits. That is, an input of 12345 would correspond to a UPC start of 00000012345
 
 EXAMPLES:
 
 upc(4210000526) => 4
 upc(3600029145) => 2
 upc(12345678910) => 4
 upc(1234567) => 0
 
 */

extension String {
  func intArray() -> [Int] {
    var intArray: [Int] = []
    for char in self {
      if let x = Int(String(char)) {
        intArray.append(x)
      }
    }
    return intArray
  }
}

func addLeadingsZerosIfNeeded(_ x: String) -> String {
  guard x.count < 11 else { return x }
  let numberOfLeadingZerosNeeded = 11 - x.count
  var leadingZeros: String = ""
  
  for _ in 1...numberOfLeadingZerosNeeded {
    leadingZeros += "0"
  }
  return leadingZeros + x
}

func getOddAndEvenSums(for array: [Int]) -> (Int, Int) {
  var evenSum: Int = 0
  var oddSum: Int = 0
  
  for (index, val) in array.enumerated() {
    if index % 2 == 0 {
      oddSum += val
    } else {
      evenSum += val
    }
  }
  return (oddSum, evenSum)
}

func upc(_ x: String) -> Int {
  var lastDigit: Int = 0
  
  let fullElevenDigits = addLeadingsZerosIfNeeded(x)
  let digitArray = fullElevenDigits.intArray()
  var (oddSum, evenSum) = getOddAndEvenSums(for: digitArray)
  
  oddSum *= 3
  oddSum += evenSum
  lastDigit = oddSum % 10
  
  return lastDigit == 0 ? 0 : 10 - lastDigit
}

upc("4210000526")
upc("3600029145")
upc("12345678910")
upc("1234567")
