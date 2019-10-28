//
//  MutiCityModel.swift
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

import UIKit
import KakaJSON

class MutiCityModel:NSObject, Convertible {
    /// 下级
    var children: Array<MutiCityModel>!
    /// 城市代码
    var code: String!
    /// 城市名称
    var name: String!
    /// 层级
    var level: Int = 1
    /// 记录是否展开
    var isExpand: Int = 0
    
    required override init() {
        
    }
}

