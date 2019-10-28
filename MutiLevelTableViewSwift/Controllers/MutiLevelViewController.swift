//
//  MutiLevelViewController.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit

class MutiLevelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: -  懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MutiLevelCell.self, forCellReuseIdentifier: NSStringFromClass(MutiLevelCell.self))
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

extension MutiLevelViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: -  UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MutiLevelCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MutiLevelCell.self), for: indexPath) as! MutiLevelCell
        cell.fillCellWith(MutiLevelViewModel: self.viewModel, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    //MARK: -  UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: MutiCityModel = self.viewModel.placesArray[indexPath.row] as! MutiCityModel
        //打印子层级元素
//        let cityArray: Array = model.children
//        if model.isExpand == 0 {
//            for i in 0..<cityArray.count {
//                let cityModel: MutiCityModel = cityArray[i]
//                print(cityModel.name as Any)
//            }
//        }
        
        let cell: MutiLevelCell = tableView.cellForRow(at: indexPath) as! MutiLevelCell
        
        if model.children == nil {
            return
        }
        if model.isExpand == 0 {
            model.isExpand = 1
            //旋转arrowImgView
            cell.rotateArrowImgView(CGFloat(Double.pi / 2))
            
            var array: NSArray = NSArray.init()
            var isMatched: Bool = false
            if self.viewModel.statesArray.count > 0 {
                for i in 0..<self.viewModel.statesArray.count {
                    let mdict: NSMutableDictionary = self.viewModel.statesArray[i] as! NSMutableDictionary
                    let name: String = mdict.object(forKey: "name") as! String
                    if name == model.name {
                        array = mdict["array"] as! NSArray
                        isMatched = true
                        break
                    }
                }
                if !isMatched {
                    array = model.children! as NSArray
                }
            } else {
                array = model.children! as NSArray
            }
            //计算level
            
            
            if !isMatched || self.viewModel.statesArray.count == 0 {
                for i in 0..<array.count {
                    let levelModel: MutiCityModel = array[i] as! MutiCityModel
                    levelModel.level = model.level + 1
                }
            }
            
            let marray = NSMutableArray.init()
            for i in 1...array.count {
                let index_path: NSIndexPath = NSIndexPath.init(row: indexPath.row + i, section: 0)
                marray.add(index_path)
                self.viewModel.placesArray.insert(array[i - 1] as! MutiCityModel, at: indexPath.row + i)
            }
            tableView.beginUpdates()
            tableView.insertRows(at: marray as! [IndexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            model.isExpand = 0
            //旋转arrowImgView
            cell.rotateArrowImgView(0)
            
            let marray: NSMutableArray = NSMutableArray.init()
            var length: Int = 0
            var start: Int = indexPath.row + 1
            for i in start..<self.viewModel.placesArray.count {
                let endModel: MutiCityModel = self.viewModel.placesArray[i] as! MutiCityModel
                if model.level >= endModel.level {
                    break
                }
                start += 1
                let index_path: NSIndexPath = NSIndexPath.init(row: i, section: 0)
                marray.add(index_path)
            }
            //计算length
            length = start - indexPath.row - 1
            if length <= 0 {
                return
            }
            //存储要删除的数组状态
            var isMatched: Bool = false
            let modelDict: NSMutableDictionary = NSMutableDictionary.init()
            for i in 0..<self.viewModel.statesArray.count {
                let mdict: NSMutableDictionary = self.viewModel.statesArray[i] as! NSMutableDictionary
                let name: String = mdict.object(forKey: "name") as! String
                if name == model.name {
                    mdict["array"] = self.viewModel.placesArray.subarray(with: NSRange.init(location: indexPath.row + 1, length: length))
                    isMatched = true
                    break
                }
            }
            if !isMatched {
                modelDict["array"] = self.viewModel.placesArray.subarray(with: NSRange.init(location: indexPath.row + 1, length: length))
                modelDict["name"] = model.name
                self.viewModel.statesArray.add(modelDict)
            }
            self.viewModel.placesArray.removeObjects(in: NSRange.init(location: indexPath.row + 1, length: length))
            //执行删除
            tableView.beginUpdates()
            tableView.deleteRows(at: marray as! [IndexPath], with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
    //设置系统cell分割线与屏幕等宽
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(cell.responds(to: #selector(setter: UITableViewCell.separatorInset))){
            cell.separatorInset = .zero
        }
        if(cell.responds(to: #selector(setter: UITableViewCell.layoutMargins))){
            cell.layoutMargins = .zero
        }
    }
    
}
