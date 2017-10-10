//
//  Pokemon.h
//  PokemonHybridiOS15
//
//  Created by Nick Reichard on 10/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//
 ///  TDOD TEST NSNUMBer
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly) NSArray<NSString *> *abilities;
// The copy operation makes a copy of an objet and then changes the pointer to refer to its copy.

-(instancetype)initWithName:(NSString *)name identifier:(NSInteger)identifier abilities:(NSArray<NSString *> *)abilities NS_DESIGNATED_INITIALIZER; // This helps the compiler out.
// The highest amount of argumetns will take the Designated INIT. 

@end

@interface Pokemon (JSONConvertible)
- (instancetype)initWithDictionary:(NSDictionary <NSString *, id> *)dictionay;

@end

NS_ASSUME_NONNULL_END
