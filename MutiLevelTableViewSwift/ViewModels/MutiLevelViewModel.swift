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
    
    func initCityResource() -> Void {
        let fileStr: String = Bundle.main.path(forResource: "cityResource", ofType: "json")!
        let jsonData = NSData.init(contentsOfFile: fileStr)
        let modelArray: Array = (jsonData?.kj.modelArray(MutiCityModel.self))!
        self.placesArray.addObjects(from: modelArray)
    }
    
    func initCraftResource() -> Void {
        //
    }
    
    //MARK: -  懒加载
    
    /// 统一存储省市县的数据model
    lazy var placesArray: NSMutableArray = {
        let placesArray = NSMutableArray.init()
        return placesArray
    }()
    /// 存储key: value
    lazy var statesDictionary: NSMutableDictionary = {
        let statesDictionary = NSMutableDictionary.init()
        return statesDictionary
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
