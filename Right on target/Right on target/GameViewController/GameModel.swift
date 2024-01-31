//
//  GameModel.swift
//  Right on target
//
//  Created by Admin on 11.02.2023.
//
import Foundation

class GameModel {
    
    var ourResultsAfterRound: [ResultItem] = []
    var number: Int = Int.random(in: 1...50)
    var round: Int = 1
    var points: Int = 0
    
    func checkGameRound(selectedNumber: Int) -> (Bool, Int, String) {
        if selectedNumber > self.number {
            self.points += 50 - selectedNumber + self.number
        } else if selectedNumber < self.number {
            self.points += 50 - self.number + selectedNumber
        } else {
            self.points += 50
        }
        let checkPoints = points
        var isFinished: Bool = false
        if round == 5 {
            let date = Date()
            let dateString = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .short)
            addToResult(newItem: ResultItem(points: "\(points)", date: dateString))
            self.round = 1
            self.points = 0
            isFinished = true
        } else {
            self.round += 1
        }
        // генерируем случайное число
        self.number = Int.random(in: 1...50)
        return (isFinished, checkPoints, "\(number)")
    }
    
    func removeAt(index: Int) {
        ourResultsAfterRound.remove(at: index)
    }
    
    func addToResult(newItem: ResultItem) {
        ourResultsAfterRound.append(newItem)
    }
    
}
