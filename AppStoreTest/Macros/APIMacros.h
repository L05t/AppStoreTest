//
//  APIMacros.h
//  BaseProjectTest
//
//  Created by 武家成 on 2019/4/18.
//  Copyright © 2019 武家成. All rights reserved.
//

#ifndef APIMacros_h
#define APIMacros_h


#ifdef DEBUG
#define API_HOST                @"http://test.xxx.com"
#else
#define API_HOST                @"http://xxx.com"
#endif



#pragma mark -- 各种接口

#define KErrorDomain  @""
#define KServerErrorDomain @""

#endif /* APIMacros_h */
