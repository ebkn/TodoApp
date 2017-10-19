//
//  TodoCollection.swift
//  TodoApp
//
//  Created by Ebinuma Kenichi on 2017/10/18.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class TodoCollection: NSObject {
  static let sharedInstance = TodoCollection()
  var todos: [Todo] = []
  
  func addTodo(_ todo: Todo) {
    todos.append(todo)
    save()
  }
  
  func save() {
    var todoList = Array<Dictionary<String, AnyObject>>()
    for todo in todos {
      let dic = TodoCollection.convertToDictionary(todo)
      todoList.append(dic)
    }
    
    let defaults = UserDefaults.standard
    defaults.set(todoList, forKey: "todoList")
    defaults.synchronize()
  }
  
  func fetchTodos() {
    let defaults = UserDefaults.standard
    if let todoList = defaults.object(forKey: "todoList") as? Array<Dictionary<String, AnyObject>> {
      for todoDic in todoList {
        let todo = TodoCollection.convertToTodoModel(todoDic)
        todos.append(todo)
      }
    }
  }
  
  class func convertToDictionary(_ todo: Todo) -> Dictionary<String, AnyObject> {
    var dic = Dictionary<String, AnyObject>()
    dic["title"] = todo.title as AnyObject
    dic["descript"] = todo.descript as AnyObject
    dic["priority"] = todo.priority.rawValue as AnyObject
    
    return dic
  }
  
  class func convertToTodoModel(_ dic: Dictionary<String, AnyObject>) -> Todo {
    let todo = Todo()
    todo.title = dic["title"] as? String
    todo.descript = dic["descript"] as? String
    todo.priority = TodoPriorityInt(rawValue: (dic["priority"] as? Int)!)!
    return todo
  }
}
