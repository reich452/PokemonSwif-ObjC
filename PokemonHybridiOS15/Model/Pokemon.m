//
//  Pokemon.m
//  PokemonHybridiOS15
//
//  Created by Nick Reichard on 10/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSInteger)identifier abilities:(NSArray<NSString *> *)abilities
{
    // TODO add a coppy
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifier;
        _abilities = abilities;
    }
    return self;
}

// Researving your seat in a movie 
-(instancetype)init
{
    return [self initWithName:@"" identifier:0 abilities:@[]];
}
@end

@implementation Pokemon (JSONConvertible)

// WHen declaring a pointer to hold the address of an object, most of the time you specify the class of the object that the pointer will refer to. However, often you need a way to create a pointer withOut knowing excatly what kind of object the pointer will be refering to. "a pointer to some kind of Objective-C object" id implies the asterisk.

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionay
{
    NSString *name = dictionay[@"name"];
    NSInteger identifier = [dictionay[@"id"] integerValue];
    NSArray *abilitiesDictionaryArray = dictionay[@"abilities"];
    
    NSMutableArray<NSString *> *abilities = [NSMutableArray new];
    
    for (NSDictionary *abilityDictionary in abilitiesDictionaryArray) {
        NSDictionary *nestedDictionary = abilityDictionary[@"ability"];
        
        NSString *abilityName = nestedDictionary[@"name"];
        
        [abilities  addObject: abilityName];
        
    }
    
    return [self initWithName:name identifier:identifier abilities:abilities];
}

@end









