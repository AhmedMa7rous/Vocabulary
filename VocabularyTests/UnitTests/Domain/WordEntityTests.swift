//
//  WordEntityTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class WordEntityTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_word_initializesWithAllProperties() {
        // Given
        let id = UUID()
        let term = "Ephemeral"
        let pronunciation = "ih-FEM-er-uhl"
        let partOfSpeech = "adjective"
        let definition = "Lasting for a very short time."
        let examples = [TestFixtures.createTestWordExample()]
        let synonyms = ["transient", "fleeting"]
        let antonyms = ["permanent", "lasting"]
        
        // When
        let word = Word(
            id: id,
            term: term,
            pronunciation: pronunciation,
            partOfSpeech: partOfSpeech,
            definition: definition,
            examples: examples,
            synonyms: synonyms,
            antonyms: antonyms
        )
        
        // Then
        XCTAssertEqual(word.id, id)
        XCTAssertEqual(word.term, term)
        XCTAssertEqual(word.pronunciation, pronunciation)
        XCTAssertEqual(word.partOfSpeech, partOfSpeech)
        XCTAssertEqual(word.definition, definition)
        XCTAssertEqual(word.examples.count, examples.count)
        XCTAssertEqual(word.synonyms, synonyms)
        XCTAssertEqual(word.antonyms, antonyms)
    }
    
    func test_word_canBeCreatedWithoutPronunciation() {
        // When
        let word = Word(
            term: "Test",
            pronunciation: nil,
            partOfSpeech: "noun",
            definition: "A test",
            examples: []
        )
        
        // Then
        XCTAssertNil(word.pronunciation)
    }
    
    func test_word_canBeCreatedWithEmptyCollections() {
        // When
        let word = Word(
            term: "Test",
            pronunciation: "test",
            partOfSpeech: "noun",
            definition: "A test",
            examples: [],
            synonyms: [],
            antonyms: []
        )
        
        // Then
        XCTAssertTrue(word.examples.isEmpty)
        XCTAssertTrue(word.synonyms.isEmpty)
        XCTAssertTrue(word.antonyms.isEmpty)
    }
    
    // MARK: - Identifiable Tests
    
    func test_word_hasUniqueId() {
        // Given
        let word1 = TestFixtures.createTestWord()
        let word2 = TestFixtures.createTestWord()
        
        // Then
        XCTAssertNotEqual(word1.id, word2.id)
    }
    
    // MARK: - Equatable Tests
    
    func test_word_equality_sameValues() {
        // Given
        let id = UUID()
        let examples = [TestFixtures.createTestWordExample()]
        
        let word1 = Word(
            id: id,
            term: "Ephemeral",
            pronunciation: "test",
            partOfSpeech: "adjective",
            definition: "test",
            examples: examples,
            synonyms: ["a"],
            antonyms: ["b"]
        )
        
        let word2 = Word(
            id: id,
            term: "Ephemeral",
            pronunciation: "test",
            partOfSpeech: "adjective",
            definition: "test",
            examples: examples,
            synonyms: ["a"],
            antonyms: ["b"]
        )
        
        // Then
        XCTAssertEqual(word1, word2)
    }
    
    func test_word_equality_differentIds() {
        // Given
        let word1 = TestFixtures.createTestWord()
        let word2 = TestFixtures.createTestWord()
        
        // Then
        XCTAssertNotEqual(word1, word2)
    }
}

// MARK: - WordExample Entity Tests

final class WordExampleEntityTests: XCTestCase {
    
    func test_wordExample_initializesWithAllProperties() {
        // Given
        let id = UUID()
        let sentence = "This is an example sentence."
        let highlightedWord = "example"
        
        // When
        let example = WordExample(
            id: id,
            sentence: sentence,
            highlightedWord: highlightedWord
        )
        
        // Then
        XCTAssertEqual(example.id, id)
        XCTAssertEqual(example.sentence, sentence)
        XCTAssertEqual(example.highlightedWord, highlightedWord)
    }
    
    func test_wordExample_hasUniqueId() {
        // Given
        let example1 = TestFixtures.createTestWordExample()
        let example2 = TestFixtures.createTestWordExample()
        
        // Then
        XCTAssertNotEqual(example1.id, example2.id)
    }
    
    func test_wordExample_equality_sameValues() {
        // Given
        let id = UUID()
        
        let example1 = WordExample(
            id: id,
            sentence: "Test sentence",
            highlightedWord: "Test"
        )
        
        let example2 = WordExample(
            id: id,
            sentence: "Test sentence",
            highlightedWord: "Test"
        )
        
        // Then
        XCTAssertEqual(example1, example2)
    }
    
    func test_wordExample_equality_differentIds() {
        // Given
        let example1 = WordExample(
            sentence: "Test sentence",
            highlightedWord: "Test"
        )
        
        let example2 = WordExample(
            sentence: "Test sentence",
            highlightedWord: "Test"
        )
        
        // Then
        XCTAssertNotEqual(example1, example2)
    }
}
