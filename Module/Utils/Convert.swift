//
//  Convert.swift
//  LS
//
//  Created by macmini on 19/6/24.
//

import Foundation

public class Convert {
    public static let shared = Logger()
    
    public func getItemDict(byIndex index: Int, dict: [String : [String]]) -> [String : [String]] {
        let keys = Array(dict.keys)
        if index >= 0 && index < keys.count {
            let key = keys[index]
            return [String(key) : dict[key]!]
        }
        return [:]
    }
    
    public func removeItem<Key: Hashable, Value>(
        at index: Int,
        from dictionary: [Key: Value],
        keyComparison: (Key, Int) -> Bool,
        shiftKey: (Key, Int) -> Key
    ) -> [Key: Value] {
        
        var updatedDictionary = dictionary
        
        // Find the item to remove using the provided keyComparison closure
        if let itemToRemove = updatedDictionary.first(where: { keyComparison($0.key, index) }) {
            updatedDictionary.removeValue(forKey: itemToRemove.key)
            
            // Shift the remaining items using the shiftKey closure
            let shiftedItems = updatedDictionary.map { (key, value) -> (Key, Value) in
                if keyComparison(key, index) {
                    // Apply the shiftKey closure to modify the key
                    return (shiftKey(key, index), value)
                } else {
                    return (key, value)
                }
            }
            
            // Convert the array back to a dictionary
            updatedDictionary = Dictionary(uniqueKeysWithValues: shiftedItems)
        }
        
        return updatedDictionary
    }
}
