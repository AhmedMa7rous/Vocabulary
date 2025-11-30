//
//  HomeViewProtocol.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func displayLoading()
    func displayWords(_ words: [Word])
    func displayError(_ message: String)
    func updateProgress(learned: Int, total: Int)
    func showWordExamples(_ examples: [WordExample], for word: Word)
    func hideWordExamples()
    func removeTopCard()
}
