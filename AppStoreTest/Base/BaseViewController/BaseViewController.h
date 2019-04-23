//
//  BaseViewController.h
//  BaseProjectTest
//
//  Created by 武家成 on 2019/4/18.
//  Copyright © 2019 武家成. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
