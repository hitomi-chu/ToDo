//
//  CreateNewToDoViewController.swift
//  ToDo
//
//  Created by Hitomi Chu on 28/9/2020.
//
import RealmSwift
import UIKit

class CreateNewToDoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textField.becomeFirstResponder()
        textField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    @objc func didTapSaveButton (){
        
        if let text = textField.text, !text.isEmpty{
            
            realm.beginWrite()
            let newItem = ToDoItem()
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            print ("Create a Task!")
        }
    }
    


}
