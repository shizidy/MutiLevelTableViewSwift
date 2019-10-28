//
//  MutiLevelViewModel.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit

class MutiLevelViewModel: NSObject {
    //重写init
    override init() {
        super.init()
        self.initCityResource()
        self.initCraftResource()
    }
    
    func initCityResource() {
        let fileStr: String = Bundle.main.path(forResource: "cityResource", ofType: "json")!
        let jsonData = NSData.init(contentsOfFile: fileStr)
        let modelArray: Array = (jsonData?.kj.modelArray(MutiCityModel.self))!
        self.placesArray.addObjects(from: modelArray)
    }
    
    func initCraftResource() {
        //
    }
    
    //MARK: -  懒加载
    
    /// 统一存储省市县的数据model
    lazy var placesArray: NSMutableArray = {
        let placesArray = NSMutableArray.init()
        return placesArray
    }()
    
    /// 记录条目关闭前的条目下的展开状态 元素是字典 @[@{@"name":name, @"array":array}, @{@"name":name1, @"array":array1}] array代表数据模型的数组 name代表地名
    lazy var statesArray: NSMutableArray = {
        let statesArray = NSMutableArray.init()
        return statesArray
    }()
    
    /// 存储数据model
    lazy var craftsArray: NSMutableArray = {
        let craftsArray = NSMutableArray.init()
        return craftsArray
    }()
    
    /// 所有craft数据model
    lazy var allCraftsArray: NSMutableArray = {
        let allCraftsArray = NSMutableArray.init()
        return allCraftsArray
    }()
    /// allCraftsArray 减去 craftsArray
    lazy var otherCraftsArray: NSMutableArray = {
        let otherCraftsArray = NSMutableArray.init()
        return otherCraftsArray
    }()
    
}
