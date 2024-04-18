//
//  addEventViewController.swift
//  NimalCalendar
//
//  Created by Ronaldo Avalos on 16/04/24.
//

import UIKit

class AddEventViewController: UIViewController {
    
    var eventTextField: UITextField!
    var eventButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEventTextField()
        setUpAddEventButton()
        
    }
    
    private func setupEventTextField() {
        eventTextField = UITextField()
        eventTextField.translatesAutoresizingMaskIntoConstraints = false
        eventTextField.placeholder = "Titulo del evento"
        eventTextField.delegate = self
        eventTextField.borderStyle = .none
        eventTextField.backgroundColor = .secundary
        eventTextField.clipsToBounds = true
        eventTextField.layer.cornerRadius = 12
        addPadding()
        view.addSubview(eventTextField)
        
        // Constraints
        NSLayoutConstraint.activate([
            eventTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            eventTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            eventTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    private func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        eventTextField.leftView = paddingView
        eventTextField.leftViewMode = .always
    }
    
    private func setUpAddEventButton(){
        
        eventButton = UIButton(type: .system)
        eventButton.translatesAutoresizingMaskIntoConstraints = false
        eventButton.setTitle("Save event", for: .normal)
        eventButton.backgroundColor = .button
        eventButton.setTitleColor(.primary, for: .normal)
        eventButton.clipsToBounds = true
        eventButton.layer.cornerRadius = 12
        eventButton.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        view.addSubview(eventButton)
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            eventButton.topAnchor.constraint(equalTo: eventTextField.bottomAnchor, constant: 20),
            eventButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            eventButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    @objc func saveEvent() {
        if let title = eventTextField.text, !title.isEmpty  {
            let event = Event(title: title , starDate: "startDate", endDate: "EndDate", color: 1)
            print(event)
        }
       
    }
    
    
    
    
    
    
}

extension AddEventViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
