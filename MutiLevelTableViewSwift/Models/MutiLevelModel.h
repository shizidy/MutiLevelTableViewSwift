//
//  MutiLevelModel.h
//  MutiLevelTableViewSwift
//
//  Created by wdyzmx on 2019/10/27.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MutiLevelModel : NSObject
/// 下级
@property (nonatomic, strong) NSArray<MutiLevelModel *> *children;
/// 城市代码
@property (nonatomic, strong) NSString *code;
/// 城市名称
@property (nonatomic, strong) NSString *name;
/// 层级
@property (nonatomic, assign) NSInteger level;
/// 记录是否展开
@property (nonatomic, assign) BOOL isExpand;
@end

NS_ASSUME_NONNULL_END
