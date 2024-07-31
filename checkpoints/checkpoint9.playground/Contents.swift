import Cocoa

func test(_ array: [Int]?) -> Int {return array?.randomElement() ?? Int.random(in: 1...100)}

let arr = [9,8,7,6,4,2,3]
let emptyArr = [Int]()

test(arr)
