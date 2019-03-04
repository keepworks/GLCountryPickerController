//
//  GLCountryManager.h
//  GLCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLCountryManager.h"

@class GLCountry;

NS_ASSUME_NONNULL_BEGIN
@interface GLCountryManager : NSObject

+ (instancetype)countryManager;

/**
 根据国家简称获得国家对象

 @param code 国家简称
 @return 找到的国际对象
 */
- (GLCountry *)countryWithCode:(NSString *)code;

/**
 国家的个数

 @return 国家的个数
 */
- (NSUInteger)numberOfCountries;

/**
 所有的国家简称集合

 @return 简称集合
 */
- (NSArray *)countryCodes;

/**
 所有的国家对象

 @return 所有国家对象
 */
- (NSArray *)allCountries;

/**
 是否存在某个国家代码

 @param code 国家代码
 @return 是否存在
 */
- (BOOL)existsCountryWithCode:(NSString *)code;

@end
NS_ASSUME_NONNULL_END
