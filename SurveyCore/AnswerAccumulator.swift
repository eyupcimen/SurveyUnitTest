//
//  AnswerAccumulator.swift
//  SurveyCore
//
//  Created by eyup cimen on 4.12.2021.
//

import Foundation

struct WeightedEntry {
    public var weight: Int = 0
    public var problems : [String] = []
    public var desires : [String] = []
    public var killerFeatures : [String] = []
    
    init(weight: Int,problems: [String] , desires: [String] , killerFeatures: [String] ) {
        self.weight = weight
        self.problems = problems
        self.desires = desires
        self.killerFeatures = killerFeatures
    }
    
    public init(commaSeparatedEntry:String) {
        let column = commaSeparatedEntry.split(separator: ",", omittingEmptySubsequences: false)
        weight = WeightedEntry.extractWeight(column: column)
        problems = WeightedEntry.extractKeywords(column: column, range: 3 ... 6)
        
        desires = WeightedEntry.extractKeywords(column: column, range: 8 ... 11)
        killerFeatures = WeightedEntry.extractKeywords(column: column, range: 13 ... 15)
    }
    
    private static func extractWeight(column:[Swift.String.SubSequence]) -> Int {
        let interestLevel1To5 = Int(column[1])!
        let fibonacci : [Int] = [0, 8, 5, 3, 2, 1]
        return fibonacci[interestLevel1To5]
    }
    
    private static func extractKeywords(column:[String.SubSequence],range:ClosedRange<Int>) -> [String] {
        return column[range]
            .filter{ !$0.isEmpty }
            .map{ String($0) }
    }
}

class AnswerAccumulator {
     
    private var entries : [WeightedEntry] = []
    
    public func accumulate(entry : WeightedEntry) {
        entries.append(entry)
    }
    
    public func scoreProblem(problem: String) -> Int {
        entries
            .filter{$0.problems.contains(problem)}
            .reduce(0) { result , entry -> Int in
                result + entry.weight
            }
    }
}
