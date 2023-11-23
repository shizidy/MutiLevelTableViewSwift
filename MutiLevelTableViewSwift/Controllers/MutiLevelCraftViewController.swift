//
//  MutiLevelCraftViewController.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit

class MutiLevelCraftViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // 添加tableView
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame:self.view.bounds, style: .plain)
        return tableView
    }()
    
    lazy var viewModel: MutiLevelViewModel = {
        let viewModel = MutiLevelViewModel.init()
        return viewModel
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MutiLevelCraftViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MutiLevelCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MutiLevelCell.self), for: indexPath) as! MutiLevelCell
        cell.setCell(viewModel: self.viewModel, indexPath: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath.row)")
    }
}

