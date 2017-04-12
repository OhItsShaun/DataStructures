//
//  PriorityQueue.swift
//  House
//
//  Created by Shaun Merchant on 08/03/2017.
//  Copyright © 2017 Shaun Merchant. All rights reserved.
//

import Foundation

/// A generic structure that organises items into order of priority using a comparitor.
/// When the queue is popped the item with the next highested priority is served first
/// instead of the order in which the item was inserted.
public struct PriorityQueue<T: Comparable> {
    
    /// Our internal representation of the data structure.
    private var heap = [T]()
    
    /// A functor to determine the order of the heap; i.e. ascending or descending.
    private let order: (T, T) -> Bool
    
    /// The amount of items contained within the queue.
    ///
    /// - Complexity: O(1)
    public var count: Int {
        get {
           return self.heap.count
        }
    }
    
    /// Retreive the queue as an array.
    ///
    /// - Complexity: O(1)
    public var array: [T] {
        get {
            return self.heap
        }
    }
    
    /// Whether the queue contains any items or not.
    ///
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        get {
            return self.heap.isEmpty
        }
    }
    
    /// Create a priority queue ordered by either ascending or descending priority.
    ///
    /// - Parameter ascending: Whether to order priority in ascending (lowest priority first) or descending (highest priority first) order.
    public init(ascending: Bool = false) {
        if ascending {
            self.init(orderingBy: { $0 > $1 })
        }
        else {
            self.init(orderingBy: { $0 < $1 })
        }
    }
    
    /// Create a priority queue ordered by a given comparitor.
    ///
    /// - Parameter comparitor: The comparitor to order priorities by.
    public init(orderingBy comparitor: @escaping (T, T) -> Bool) {
        self.order = comparitor
    }
    
    /// Insert an item into the queue.
    ///
    /// - Complexity: O(log n) where _n_ is the size of the queue.
    ///
    /// - Parameter item: The item to be inserted into the queue.
    public mutating func insert(_ item: T) {
        self.heap.append(item)
        self.bubbleUp(from: heap.count - 1)
    }
    
    /// Remove and return the element with the highest priority.
    ///
    /// - Complexity: O(log n) where _n_ is the size of the queue.
    ///
    /// - Returns: The item with the highest priority in the queue, otherwise `nil` if the queue is empty.
    public mutating func pop() -> T? {
        guard !self.isEmpty else {
            return nil
        }
        
        if self.count == 1 {
            return self.heap.removeFirst()
        }
        
        swap(&self.heap[0], &self.heap[self.heap.count - 1])
        
        let highestPriority = self.heap.removeLast()
        
        self.bubbleDown(from: 0)
        
        return highestPriority
    }
    
    /// Preview the highest priority item in the queue.
    ///
    /// - Important: Peek does not remove the item from the queue.
    ///
    /// - Complexity: O(1)
    ///
    /// - Returns: The item with the highest priority in the queue, otherwise `nil` if the queue is empty.
    public func peek() -> T? {
        return self.heap.first
    }
    
    /// Remove all items from the queue.
    ///
    /// - Complexity: O(n) where _n_ is the size of the queue.
    public mutating func removeAll() {
        self.heap.removeAll()
    }
    
    /// Correct an array that violates the condition of a binary heap whereby a parent node has a lower priority than its children.
    ///
    /// - Complexity: O(log n) where _n_ is the size of the queue.
    ///
    /// - Parameter index: The index from which to correct downards in the binary heap.
    private mutating func bubbleDown(from index: Int) {
        var parentIndex = index
        
        while 2 * parentIndex + 1 < self.heap.count {
            var childIndex = 2 * parentIndex + 1
            
            if childIndex < (self.heap.count - 1) && order(self.heap[childIndex], self.heap[childIndex + 1]) {
                childIndex += 1
            }
            
            guard self.order(self.heap[parentIndex], self.heap[childIndex]) else {
                break
            }
            
            swap(&self.heap[parentIndex], &self.heap[childIndex])
            parentIndex = childIndex
        }
    }
    
    /// Correct an array that violates the condition of a binary heap whereby a child node has a greater priority than its parent.
    ///
    /// - Complexity: O(log n) where _n_ is the size of the queue.
    ///
    /// - Parameter index: The index from which to correct upwards in the binary heap.
    private mutating func bubbleUp(from index: Int) {
        var childIndex = index
        
        while childIndex > 0 && self.order(self.heap[(childIndex - 1) / 2], self.heap[childIndex]) {
            swap(&self.heap[(childIndex - 1) / 2], &self.heap[childIndex])
            childIndex = (childIndex - 1) / 2
        }
    }
}
