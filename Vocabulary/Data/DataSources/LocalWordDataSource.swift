//
//  LocalWordDataSource.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class LocalWordDataSource {
    
    func getWords() -> [Word] {
        return [
            Word(
                term: "Ephemeral",
                pronunciation: "ih-FEM-er-uhl",
                partOfSpeech: "adjective",
                definition: "Lasting for a very short time; transitory.",
                examples: [
                    WordExample(
                        sentence: "The ephemeral beauty of cherry blossoms reminds us to appreciate fleeting moments.",
                        highlightedWord: "ephemeral"
                    ),
                    WordExample(
                        sentence: "Social media fame is often ephemeral, disappearing as quickly as it arrives.",
                        highlightedWord: "ephemeral"
                    )
                ],
                synonyms: ["transient", "fleeting", "momentary"],
                antonyms: ["permanent", "lasting", "enduring"]
            ),
            Word(
                term: "Serendipity",
                pronunciation: "ser-uhn-DIP-i-tee",
                partOfSpeech: "noun",
                definition: "The occurrence of events by chance in a happy or beneficial way.",
                examples: [
                    WordExample(
                        sentence: "Meeting my co-founder at that conference was pure serendipity.",
                        highlightedWord: "serendipity"
                    ),
                    WordExample(
                        sentence: "The scientific discovery happened by serendipity when the researcher made an unexpected observation.",
                        highlightedWord: "serendipity"
                    )
                ],
                synonyms: ["chance", "fortune", "luck"],
                antonyms: ["misfortune", "design", "plan"]
            ),
            Word(
                term: "Eloquent",
                pronunciation: "EL-uh-kwuhnt",
                partOfSpeech: "adjective",
                definition: "Fluent or persuasive in speaking or writing.",
                examples: [
                    WordExample(
                        sentence: "Her eloquent speech about climate change moved the entire audience to tears.",
                        highlightedWord: "eloquent"
                    ),
                    WordExample(
                        sentence: "The lawyer made an eloquent argument that convinced the jury of his client's innocence.",
                        highlightedWord: "eloquent"
                    )
                ],
                synonyms: ["articulate", "persuasive", "expressive"],
                antonyms: ["inarticulate", "hesitant", "awkward"]
            ),
            Word(
                term: "Resilient",
                pronunciation: "rih-ZIL-yuhnt",
                partOfSpeech: "adjective",
                definition: "Able to withstand or recover quickly from difficult conditions.",
                examples: [
                    WordExample(
                        sentence: "Children are remarkably resilient and adapt quickly to new environments.",
                        highlightedWord: "resilient"
                    ),
                    WordExample(
                        sentence: "The company proved resilient during the economic crisis, emerging stronger than before.",
                        highlightedWord: "resilient"
                    )
                ],
                synonyms: ["strong", "tough", "adaptable"],
                antonyms: ["fragile", "weak", "vulnerable"]
            ),
            Word(
                term: "Ubiquitous",
                pronunciation: "yoo-BIK-wi-tuhs",
                partOfSpeech: "adjective",
                definition: "Present, appearing, or found everywhere.",
                examples: [
                    WordExample(
                        sentence: "Smartphones have become ubiquitous in modern society, carried by billions worldwide.",
                        highlightedWord: "ubiquitous"
                    ),
                    WordExample(
                        sentence: "Coffee shops are ubiquitous in this city, with one on nearly every block.",
                        highlightedWord: "ubiquitous"
                    )
                ],
                synonyms: ["omnipresent", "pervasive", "widespread"],
                antonyms: ["rare", "scarce", "absent"]
            )
        ]
    }
}
