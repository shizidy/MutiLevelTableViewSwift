//
//  MutiLevelViewController.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit

// 声明一个闭包
typealias CallBack = (_ name: NSString) -> ()

class MutiLevelViewController: UIViewController {
    
    var callBack: CallBack?
    var call_Back: ((_ name: NSString) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: -  懒加载
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
    // MARK: -  UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MutiLevelCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MutiLevelCell.self), for: indexPath) as! MutiLevelCell
        cell.fillCellWith(MutiLevelViewModel: self.viewModel, indexPath: indexPath)
        return cell
    }
    
    // MARK: -  UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: MutiCityModel = self.viewModel.placesArray[indexPath.row] as! MutiCityModel
        let cell: MutiLevelCell = tableView.cellForRow(at: indexPath) as! MutiLevelCell
        
        if model.children == nil || model.children.count == 0 {
            // 此处可回调选择
            self.callBack!(model.name! as NSString)
            self.call_Back!(model.name! as NSString)
//            self.navigationController?.popViewController(animated: true)
            return
        }
        
        if model.isExpand == 0 {
            //MARK: - 展开层级
            model.isExpand = 1
            //旋转arrowImgView
            cell.rotateArrowImgView(CGFloat(Double.pi / 2))
            
            var modelArray: NSArray = []
            for code in self.viewModel.statesDictionary.allKeys {
                if (code as! String) == model.code {
                    modelArray = self.viewModel.statesDictionary[code] as! NSArray
                    break
                }
            }
            // 没有匹配到
            if modelArray.count == 0 {
                modelArray = model.children! as NSArray
                // 计算level
                for subModel in modelArray {
                    (subModel as! MutiCityModel).level = model.level + 1
                }
            }
            // 计算indexPathArray
            let indexPathArray: NSMutableArray = NSMutableArray.init()
            for i in 0..<modelArray.count {
                let tmpIndexPath = NSIndexPath.init(row: indexPath.row + 1 + i, section: 0)
                indexPathArray.add(tmpIndexPath)
                // 插入数据model
                self.viewModel.placesArray.insert(modelArray[i], at: indexPath.row + 1 + i)
            }
            // 插入行
            tableView.beginUpdates()
            tableView.insertRows(at: indexPathArray as! [IndexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            // MARK: - 关闭层级
            model.isExpand = 0
            //旋转arrowImgView
            cell.rotateArrowImgView(0)
            
            /*
             1.关闭前先把省/市/县展开时的数据保存起来
             2.怎么查找要保存的数据，思路：1.两个相同层级（level）之间的数据即为该层级的展开状态下的数据 2.该层级与首次找到比他大的层级之间的数据
             3.例如北京市与河北省之间，假如北京这一层级处于展开状态，在placesArray中寻找北京（level1=0）与河北省（level2=0）判断条件level1=level2，把这两者中间的数据保存起来，或者北京市市辖区（level1=1）与河北省（level2=0）之间的数据，判断条件level1>level2
             */
            let indexPathArray: NSMutableArray = NSMutableArray.init()
            let modelArray: NSMutableArray = NSMutableArray.init()
            var length: NSInteger = 0
            var count: Int = indexPath.row + 1
            for i in indexPath.row + 1..<self.viewModel.placesArray.count {
                let tmpModel: MutiCityModel = self.viewModel.placesArray[i] as! MutiCityModel
                if model.level >= tmpModel.level {
                    break
                }
                count += 1
                let tmpIndexPath: NSIndexPath = NSIndexPath.init(row: i, section: 0)
                indexPathArray.add(tmpIndexPath)
                modelArray.add(tmpModel)
            }
            length = count - indexPath.row - 1
            if length == 0 {
                return
            }
            // 更新statesDictionary
            self.viewModel.statesDictionary[model.code!] = modelArray
            // 删除数据model
            self.viewModel.placesArray.removeObjects(in: NSMakeRange(indexPath.row + 1, length))
            //执行删除
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPathArray as! [IndexPath], with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
    // 设置系统cell分割线与屏幕等宽
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    
}
