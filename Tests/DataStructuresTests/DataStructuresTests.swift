import XCTest
@testable import DataStructures

class DataStructuresTests: XCTestCase {

    func testSmallestPriorityQueue() {
        self.popPriorityQueue(using: min, ascending: true)
    }
    
    func testHighestPriorityQueue() {
        self.popPriorityQueue(using: max, ascending: false)
    }
    
    func testBasicSort() {
        
        let items = [5, 6, 2, 8]
        
        var queue1 = PriorityQueue<Int>(ascending: true)
        var queue2 = PriorityQueue<Int>(ascending: false)
        var queue3 = PriorityQueue<Int>()
        
        for item in items {
            queue1.insert(item)
            queue2.insert(item)
            queue3.insert(item)
        }
        
        XCTAssert(queue1.pop()! == 2)
        XCTAssert(queue2.pop()! == 8)
        XCTAssert(queue3.pop()! == 8)
    }
    
    func popPriorityQueue(using comparitor: (UInt32, UInt32) -> UInt32, ascending: Bool) {
        var queue = PriorityQueue<UInt32>(ascending: ascending)
        var manualList = [UInt32]()
        manualList.reserveCapacity(1000)
        
        for _ in 0..<1000 {
            let random = arc4random()
            queue.insert(random)
            manualList += [random]
        }
        
        guard let highestPriority = queue.pop() else {
            XCTFail("No item returned.")
            return
        }
        
        var smallest = manualList[0]
        for item in manualList {
            smallest = comparitor(item, smallest)
        }
        
        XCTAssert(highestPriority == smallest, "Comparitor: \(smallest). Queue: \(highestPriority).")
    }
    
    func testOrderedPriorityQueue() {
        
        var queue = PriorityQueue<Int>(ascending: true)
        let items = [5, 2, 8, 7, 9, 10, 3, 5, 2, 7, 7, 2, 102, 54]
        for item in items {
            queue.insert(item)
        }
        
        let sortedItems = items.sorted()
        
        for item in sortedItems {
            if let queueItem = queue.pop() {
                XCTAssert(item == queueItem)
            }
            else {
                XCTFail("Loss of data for sorted item: \(item)")
            }
        }
    }
    
    func testHeapifyAlgorithm() {
        
        var queue = PriorityQueue<Int>(ascending: true)
        let items = [5, 6, 2, 8, 10, 2, 3, 6, 2]
        for item in items {
            queue.insert(item)
        }
        
        let sortedItems = items.sorted()
        
        for index in 0..<5 {
            if let queueItem = queue.pop() {
                XCTAssert(queueItem == sortedItems[index])
            }
            else {
                XCTFail("Loss of data for sorted item: \(sortedItems[index])")
            }
        }
        
        let items2 = [6, 2, 8, 9, 1, 4]
        for item in items2 {
            queue.insert(item)
        }
        
        let sortedItems2 = (sortedItems.dropFirst(5) + items2).sorted()
        
        for item in sortedItems2 {
            if let queueItem = queue.pop() {
                XCTAssert(queueItem == item)
            }
            else {
                XCTFail("Loss of data for sorted item: \(item)")
            }
        }
        
    }


    static var allTests = [
        ("testSmallestPriorityQueue", testSmallestPriorityQueue),
        ("testHighestPriorityQueue", testHighestPriorityQueue),
        ("testBasicSort", testBasicSort),
        ("testOrderedPriorityQueue", testOrderedPriorityQueue),
        ("testHeapifyAlgorithm", testHeapifyAlgorithm),
    ]
}
