//
//  ViewController.swift
//  MySqlite
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 huxinqian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stuName: UITextField!
    @IBOutlet weak var stuPhone: UITextField!
    let db = SQLiteDB.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        //将空数据库data.db拷贝到(home目录下的Document下）
        var result = SQLiteDB.shared.open(dbPath: "", copyFile: true)
        print("result:\(result)")
        //建表
        let r = db.execute(sql: "create table if not exists person(name varchar(20),phone varchar(20))")
        print("result:\(r)")
        //打印home目录和应用目录
        print(NSHomeDirectory())
        print(Bundle.main.bundlePath)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func add(_ sender: Any) {
       let r = db.execute(sql: "insert into person values('\(stuName.text!)','\(stuPhone.text!)')")
        print("result:\(r)")
    }
    @IBAction func update(_ sender: Any) {
        let r = db.execute(sql: "update person set phone = '\(stuPhone.text!)' where name = '\(stuName.text!)'")
        print("result:\(r)")
    }
    @IBAction func del(_ sender: Any) {
        let r = db.execute(sql: "delete from person where name = '\(stuName.text!)'")
        print("result:\(r)")
    }
    @IBAction func query(_ sender: Any) {
       let persons = db.query(sql: "select * from person where name = '\(stuName.text!)'")
        if let person = persons.first,let phone = person["phone"] as? String {
            stuPhone.text = phone
        }
    }
}

