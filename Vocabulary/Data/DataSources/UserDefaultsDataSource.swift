//
//  UserDefaultsDataSource.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class UserDefaultsDataSource {
    private let userDefaults: UserDefaults
    private let onboardingKey = "isOnboardingCompleted"
    private let learnedWordsKey = "learnedWords"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func isOnboardingCompleted() -> Bool {
        return userDefaults.bool(forKey: onboardingKey)
    }
    
    func markOnboardingCompleted() {
        userDefaults.set(true, forKey: onboardingKey)
    }
    
    func getLearnedWordIds() -> [String] {
        return userDefaults.stringArray(forKey: learnedWordsKey) ?? []
    }
    
    func markWordAsLearned(wordId: UUID) {
        var learnedIds = getLearnedWordIds()
        let idString = wordId.uuidString
        
        if !learnedIds.contains(idString) {
            learnedIds.append(idString)
            userDefaults.set(learnedIds, forKey: learnedWordsKey)
        }
    }
    
    func getLearnedWordsCount() -> Int {
        return getLearnedWordIds().count
    }
}
