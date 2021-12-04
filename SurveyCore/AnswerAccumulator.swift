//
//  AnswerAccumulator.swift
//  SurveyCore
//
//  Created by eyup cimen on 4.12.2021.
//

import Foundation

class WeightedEntry {
    var weight: Int = 0
    var problems : [String] = []
    var desires : [String] = []
    var killerFeatures : [String] = []
    
    internal init(weight: Int = 0,problems: [String] = [], desires: [String] = [], killerFeatures: [String] = []) {
        self.weight = weight
        self.problems = problems
        self.desires = desires
        self.killerFeatures = killerFeatures
    }

}

class AnswerAccumulator {
     
    private var entries : [WeightedEntry] = []
    
    public func accumulate(entry : WeightedEntry) {
        entries.append(entry)
    }
    
    public func scoreProblem(problem: String) -> Int {
        entries.reduce(0) { result , entry -> Int in
            if entry.problems.contains(problem) {
                return result + entry.weight
            } else {
                return result
            }
        }
    }
}
