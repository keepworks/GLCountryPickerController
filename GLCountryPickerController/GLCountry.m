//
//  GLCountry.m
//  GLCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "GLCountry.h"
#import "GLCountryManager.h"

static NSString * const kDefaultLocale = @"en";

@implementation GLCountry

+ (instancetype)countryWithCountryCode:(NSString *)code
{
    return [[GLCountry alloc] initWithCountryCode:code];
}

- (instancetype)init
{
    NSException* exception = [NSException
                              exceptionWithName:@"UnsupportedOperationException"
                              reason:@"This class cannot be instantiated."
                              userInfo:nil];
    @throw exception;
}

- (instancetype)initWithCountryCode:(NSString *)code
{
    self = [super init];
    
    if (self)
    {
        _countryCode = code;
    }
    
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [self isEqualToCountry:other];
}

- (BOOL)isEqualToCountry:(GLCountry *)aCountry
{
    if (self == aCountry)
        return YES;
    
    return [[self countryCode] isEqualToString:[aCountry countryCode]];
}

- (NSString *)name
{
    return [self countryNameWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
}
    
- (NSString *)dialingCode
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code == %@", _countryCode];
    NSString *countriesPath = [bundle pathForResource:@"GLCountryPickerController.bundle/CallingCodes" ofType:@"plist"];
    NSArray *countriesArray = [NSArray arrayWithContentsOfFile:countriesPath];
    NSDictionary *filteredCountry = [countriesArray filteredArrayUsingPredicate:predicate].firstObject;
    
    return filteredCountry.count ? filteredCountry[@"dial_code"] : @"";
}

- (NSString *)countryNameWithLocale:(NSLocale *)locale
{
    NSString *localisedCountryName = [locale
                                     displayNameForKey:NSLocaleCountryCode value:self.countryCode];

    return localisedCountryName;
}

- (NSString *)countryNameWithLocaleIdentifier:(NSString *)localeIdentifier
{
    NSLocale* locale = [NSLocale localeWithLocaleIdentifier:localeIdentifier];
    return [self countryNameWithLocale:locale];
}

/* 国旗对象 */
- (UIImage * _Nullable)nationalFlag {
    
    UIImage *flagImg = [UIImage imageNamed:[NSString stringWithFormat:@"GLCountryPickerController.bundle/%@.png",_countryCode]];
    return flagImg;
}
@end
