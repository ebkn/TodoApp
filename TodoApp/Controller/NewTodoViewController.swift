//
//  NewTodoViewController.swift
//  TodoApp
//
//  Created by Ebinuma Kenichi on 2017/10/18.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class NewTodoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
  @IBOutlet weak var todoField: UITextField!
  @IBOutlet weak var descriptionView: UITextView!
  @IBOutlet weak var prioritySegment: UISegmentedControl!
  
  let todoCollection = TodoCollection.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    todoField.layer.cornerRadius = 5
    
    descriptionView.layer.cornerRadius = 5
    descriptionView.layer.borderWidth = 1
    descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
    self.view.addGestureRecognizer(tapGesture)
    
    todoField.delegate = self
    descriptionView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor: UIColor.white
    ]
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.close(_:)))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.save(_:)))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc func close(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func save(_ sender: AnyObject) {
    if todoField.text!.isEmpty {
      let alertController = UIAlertController(title: "保存できません", message: "タイトルが空です", preferredStyle: UIAlertControllerStyle.alert)
      let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
      alertController.addAction(confirmAction)
      
      self.present(alertController, animated: true, completion: nil)
    } else {
      let todo = Todo()
      todo.title = todoField.text
      todo.descript = descriptionView.text
      todo.priority = TodoPriorityInt(rawValue: prioritySegment.selectedSegmentIndex)!
      todoCollection.addTodo(todo)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @objc func tapGesture(_ sender: AnyObject) {
    todoField.resignFirstResponder()
    descriptionView.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    todoField.resignFirstResponder()
    return true
  }
}
