//
//  TodoListTableTableViewController.swift
//  TodoApp
//
//  Created by Ebinuma Kenichi on 2017/10/12.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class TodoListTableTableViewController: UITableViewController {
  let todoCollection = TodoCollection.sharedInstance

  override func viewDidLoad() {
    super.viewDidLoad()
    
    todoCollection.fetchTodos()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor: UIColor.white
    ]
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.newTodo(_:)))
    self.navigationItem.leftBarButtonItem = editButtonItem
    self.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoCollection.todos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
    
    let todo = todoCollection.todos[indexPath.row]
    cell.textLabel!.text = todo.title
    cell.detailTextLabel?.text = todo.descript
    
    let priorityIcon = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    priorityIcon.layer.cornerRadius = 7.5
    priorityIcon.layer.backgroundColor = todo.priority.color().cgColor
    cell.accessoryView = priorityIcon
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      todoCollection.todos.remove(at: indexPath.row)
      todoCollection.save()
      tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
    default:
      return
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let todo = todoCollection.todos[sourceIndexPath.row]
    todoCollection.todos.remove(at: sourceIndexPath.row)
    todoCollection.todos.insert(todo, at: sourceIndexPath.row)
    todoCollection.save()
  }
  
  @objc func newTodo(_ sender: AnyObject) {
    self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
  }
}
