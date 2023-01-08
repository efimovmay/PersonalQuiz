//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by brubru on 18.08.2022.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // 3. Отобразить результаты в соотвствии с этим животным

    @IBOutlet var youAnimalTextFeeld: UILabel!
    @IBOutlet var selfTextFeeld: UILabel!
    @IBOutlet var answersTextFeeld: UILabel!
    
    // MARK: - Public Properties
    var answersChosen: [Answer]!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        getMostRepeadAnimal()
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

private extension ResultViewController {
    
    func getMostRepeadAnimal() {
        
        var mostRepeadAnimals: [AnimalType: Int] = [:]
        var suitableAnswer: [String] = []
        
        let types = answersChosen.map { $0.type }
        for type in types {
            mostRepeadAnimals[type] = (mostRepeadAnimals[type] ?? 0) + 1
        }
        
        let sortedMostRepeadAnimals = mostRepeadAnimals.sorted{ $0.value > $1.value }
        guard let mostRepeadAnimal = sortedMostRepeadAnimals.first?.key else { return }
        
        for answer in answersChosen {
            if answer.type == mostRepeadAnimal {
                suitableAnswer.append(answer.title)
            }
        }
        UI(animal: mostRepeadAnimal, answers: suitableAnswer)
    }
    
    func UI(animal: AnimalType, answers: [String]){
        
        youAnimalTextFeeld.text = "Вы - \(animal.rawValue)"
        selfTextFeeld.text = "\(animal.definition)"
        answersTextFeeld.text = "Совпали результаты: \(answers.joined(separator: ", "))"
        
    }
}
