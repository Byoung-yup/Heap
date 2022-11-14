//
//  main.swift
//  Heap
//
//  Created by 김병엽 on 2022/11/15.
//
// Reference: https://gist.github.com/JCSooHwanCho/a3f070c2160bb8c0047a5ddbb831f78e

// minimum heap
struct Heap<T> {
    var nodes: Array<T> = []
    let comparer: (T, T) -> Bool
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    func peek() -> T? {
        return nodes.first
    }
    
    mutating func insert(_ element: T) {
        var index = nodes.count
        
        nodes.append(element)
        
        while index > 0, comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }
    
    mutating func delete() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }
        
        if nodes.count == 1 {
            return nodes.removeFirst()
        }
        
        let result = nodes.first
        nodes.swapAt(0, nodes.count - 1)
        _ = nodes.popLast()
        
        var index = 0
        
        while index < nodes.count {
            let left = index * 2 + 1
            let right = left + 1
            
            if right < nodes.count {
                if !comparer(nodes[left], nodes[right]), !comparer(nodes[index], nodes[right]) {
                    nodes.swapAt(index, right)
                    index = right
                } else if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else if left < nodes.count {
                if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else {
                break
            }
        }
        
        return result
    }
}

extension Heap where T: Comparable {
    init() {
        self.init(comparer: <)
    }
}
