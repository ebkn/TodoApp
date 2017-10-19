//
//  Todo.swift
//  TodoApp
//
//  Created by Ebinuma Kenichi on 2017/10/12.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

enum TodoPriorityInt: Int {
  case Low    = 0
  case Middle = 1
  case High   = 2
  
  func color() -> UIColor {
    switch self {
    case .High:
      return UIColor.red
    case .Middle:
      return UIColor.yellow
    default:
      return UIColor.green
    }
  }
}

class Todo: NSObject {
  var title: String?
  var descript: String?
  var priority: TodoPriorityInt = TodoPriorityInt.Low
}
