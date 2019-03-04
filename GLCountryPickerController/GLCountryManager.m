//
//  GLCountryManager.m
//  Push Money Mobile
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "GLCountryManager.h"
#import "GLCountry.h"

@implementation GLCountryManager
{
    NSArray *countriesArray;
}

static GLCountryManager *_countryManager;

+ (void)initialize
{
    static BOOL initialized = NO;
    
    if (!initialized)
    {
        initialized = YES;
        _countryManager = [[GLCountryManager alloc] init];
    }
}

+ (instancetype)countryManager
{
    return _countryManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self loadCountries];
    }
    
    return self;
}

- (void)loadCountries
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *countriesPath = [bundle pathForResource:@"GLCountryPickerController.bundle/CallingCodes" ofType:@"plist"];
    
    countriesArray = [NSArray arrayWithContentsOfFile:countriesPath];
    NSMutableArray *formattedCountries = [NSMutableArray array];
    for (NSDictionary *details in countriesArray)
    {
        [formattedCountries addObject:[details valueForKey:@"code"]];
    }
    
    countriesArray = formattedCountries.mutableCopy;
    
    if (!countriesArray)
    {
        [NSException raise:@"Countries could not be loaded" format:@"Country array is null: [%@]", countriesArray];
    }
}

- (NSUInteger)numberOfCountries
{
    return [countriesArray count];
}

- (GLCountry *)countryWithCode:(NSString *)code
{
    return [GLCountry countryWithCountryCode:code];
}

- (BOOL)existsCountryWithCode:(NSString *)code
{
    return [countriesArray containsObject:code];
}

- (NSArray *)countryCodes
{
    return [NSArray arrayWithArray:countriesArray];
}

- (NSArray *)allCountries
{
    NSMutableArray *countries = [[NSMutableArray alloc] init];
    
    for (id code in countriesArray)
    {
        [countries addObject:[self countryWithCode:code]];
    }
    
    return countries;
}

@end
