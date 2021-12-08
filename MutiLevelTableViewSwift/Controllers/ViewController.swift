//
//  ViewController.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button1: UIButton!
    var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        button1 = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 50))
        self.view.addSubview(button1)
        var point = self.view.center
        point.y -= 50
        button1.center = point
        button1.backgroundColor = .red
        button1.setTitleColor(.white, for: .normal)
        button1.setTitle("多层级CityTableView", for: .normal)
        button1.addTarget(self, action: #selector(button1Click(sender:)), for: .touchUpInside)
        
        button2 = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 50))
        self.view.addSubview(button2)
        point = self.view.center
        point.y += 50
        button2.center = point
        button2.backgroundColor = .red
        button2.setTitleColor(.white, for: .normal)
        button2.setTitle("多层级CraftTableView", for: .normal)
        button2.addTarget(self, action: #selector(button2Click(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func button1Click(sender: UIButton) {
        let viewController = MutiLevelViewController.init()
        self.navigationController?.pushViewController(viewController, animated: true)
        // 解决循环引用问题
//        weak var weakself = self
        weak var weakVC = viewController
        // 闭包回调
        viewController.callBack = {
            (name) -> Void in
            NSLog("你的选择是：\(name)")
            weakVC?.navigationController?.popViewController(animated: true)
        }
        viewController.call_Back = {
            (name) -> Void in
            NSLog("你的选择是：\(name)")
            weakVC?.navigationController?.popViewController(animated: true)
        }
    }
        
    @objc func button2Click(sender: UIButton) {
        let viewController = MutiLevelCraftViewController.init()
        self.navigationController?.pushViewController(viewController, animated: true)
    }


}

