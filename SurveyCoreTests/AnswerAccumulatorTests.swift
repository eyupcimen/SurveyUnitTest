//
//  AnswerAccumulatorTests.swift
//  SurveyCoreTests
//
//  Created by eyup cimen on 4.12.2021.
//

import XCTest
@testable import SurveyCore

class AnswerAccumulatorTests: XCTestCase {
    
    private var sut : AnswerAccumulator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AnswerAccumulator()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
 
//    func test_oneEntry() throws {
//        let entry = WeightedEntry(weight: 8, problems: ["P1"], desires: [], killerFeatures: [])
//        sut.accumulate(entry:entry)
//        let score: Int = sut.scoreProblem(problem: "P1")
//        XCTAssertEqual(score, 8)
//    }
//
//    func test_oneEntry_withDifferentWeight() throws {
//        let entry = WeightedEntry(weight: 5, problems: ["P1"], desires: [], killerFeatures: [])
//        sut.accumulate(entry:entry)
//        let score:Int = sut.scoreProblem(problem: "P1")
//        XCTAssertEqual(score, 5)
//    }
    
//    func test_oneEntry_withDifferentProblem() throws {
//        let entry = WeightedEntry(weight: 5, problems: ["P1"], desires: [], killerFeatures: [])
//
//        sut.accumulate(entry: entry)
//        let score: Int = sut.scoreProblem(problem: "P2")
//
//        XCTAssertEqual(score, 0)
//    }
//
//    func test_twoEntries() throws {
//
//        let entry1 = WeightedEntry(weight: 8, problems: ["P1"], desires: [], killerFeatures: [])
//        let entry2 = WeightedEntry(weight: 5, problems: ["P1"], desires: [], killerFeatures: [])
//
//        sut.accumulate(entry: entry1)
//        sut.accumulate(entry: entry2)
//
//        let score: Int = sut.scoreProblem(problem: "P1")
//
//        XCTAssertEqual(score, 8 + 5)
//    }
    
    func test_scoreMultipleProblems() throws {
        
        let entry1 = WeightedEntry(weight: 8, problems: ["P1","P2"], desires: [], killerFeatures: [])
        let entry2 = WeightedEntry(weight: 5, problems: ["P2","P3"], desires: [], killerFeatures: [])
        
        sut.accumulate(entry: entry1)
        sut.accumulate(entry: entry2)
        
        let score: Int = sut.scoreProblem(problem: "P2")
        
        XCTAssertEqual(score, 8 + 5)
    }
    
    func test_scoreMultipleDesires() throws {
        
        let entry1 = WeightedEntry(weight: 8, problems: [], desires: ["D1","D2"], killerFeatures: [])
        let entry2 = WeightedEntry(weight: 5, problems: [], desires: ["D2","D3"], killerFeatures: [])
        
        sut.accumulate(entry: entry1)
        sut.accumulate(entry: entry2)
        
        let score: Int = sut.scoreDesire(desire: "D2")
        
        XCTAssertEqual(score, 8 + 5)
    }
    
    func test_scoreMultipleKillerFeatures() throws {
        
        let entry1 = WeightedEntry(weight: 8, problems: [], desires: [], killerFeatures: ["K1","K2"])
        let entry2 = WeightedEntry(weight: 5, problems: [], desires: [], killerFeatures: ["K2","K3"])
        
        sut.accumulate(entry: entry1)
        sut.accumulate(entry: entry2)
        
        let score: Int = sut.scoreKillerFeature(killerFeature: "K2")
        
        XCTAssertEqual(score, 8 + 5)
    }
    
    func test_accumulate_shouldGatherListOfUniqueProblems () throws {
       
        let entry1 = WeightedEntry(weight: 8, problems: ["P1","P2"], desires: [], killerFeatures: [])
        let entry2 = WeightedEntry(weight: 5, problems: ["P2","P3"], desires: [], killerFeatures: [])
        
        sut.accumulate(entry: entry1)
        sut.accumulate(entry: entry2)
        
        let result = sut.problems()
        
        XCTAssertEqual(result ,["P1", "P2", "P3"])
        
    }

}
