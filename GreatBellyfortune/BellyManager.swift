//
//  BellyManager.swift
//  GreatBellyfortune
//
//  Created by admin on 25.06.2024.
//

import Foundation

class BellyManager {
    
    static func getCoins() -> Int {
        guard let bank = UserDefaults.standard.value(forKey: "coins") as? Int else {
            UserDefaults.standard.setValue(0, forKey: "coins")
            return 0
        }
        return bank
    }
    
    static func addCoins(_ coins: Int) {
        guard let bank = UserDefaults.standard.value(forKey: "coins") as? Int else {
            UserDefaults.standard.setValue(coins, forKey: "coins")
            return
        }
        UserDefaults.standard.setValue(coins + bank, forKey: "coins")
    }
    
    static func buySomething(for coins: Int) -> Bool {
        guard let bank = UserDefaults.standard.value(forKey: "coins") as? Int else {
            UserDefaults.standard.setValue(0, forKey: "coins")
            return false
        }
        if bank >= coins {
            UserDefaults.standard.setValue(bank - coins, forKey: "coins")
            return true
        } else {
            return false
        }
    }
    
    static func findMask() {
        guard let mask = UserDefaults.standard.value(forKey: "mask") as? Int else {
            UserDefaults.standard.setValue(1, forKey: "mask")
            return
        }
        if mask < 3 {
            UserDefaults.standard.setValue(mask + 1, forKey: "mask")
        }
    }
    
    static func getMaskCount() -> Int {
        guard let mask = UserDefaults.standard.value(forKey: "mask") as? Int else {
            return 0
        }
        return mask
    }
    
    static func getTickets() -> [Bool] {
        guard let tickets = UserDefaults.standard.value(forKey: "tickets") as? [Bool] else {
            UserDefaults.standard.setValue([false, false, false, false], forKey: "tickets")
            return [false, false, false, false]
        }
        return tickets
    }
    
    static func buyTicket(_ index: Int) {
        var res = [false, false, false, false]
        res[index] = true
        guard let tickets = UserDefaults.standard.value(forKey: "tickets") as? [Bool] else {
            UserDefaults.standard.setValue(res, forKey: "tickets")
            return
        }
        res = tickets
        res[index] = true
        UserDefaults.standard.setValue(res, forKey: "tickets")
        
    }
    
}
