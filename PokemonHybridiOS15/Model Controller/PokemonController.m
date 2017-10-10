//
//  PokemonController.m
//  PokemonHybridiOS15
//
//  Created by Nick Reichard on 10/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import "PokemonController.h"
#import "Pokemon.h"
#import "PokemonHybridiOS15-Swift.h"

//const merely modifies a variable so that the compiler will flag an error if you try to change it
// const are more compiler and debugger friendly than define . variable whose content cannot be changed

static NSString * const baseURLString = @"http://pokeapi.co/api/v2/pokemon";

@implementation PokemonController

+ (PokemonController *)sharedController
{
    static PokemonController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PokemonController new];
    });
    return sharedInstance;
    
}


- (void)fetchPokemonForSearchTerm:(NSString *)searchTerm completion:(void (^)(Pokemon *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];\
    NSURL *searchUrl = [baseURL URLByAppendingPathComponent:[searchTerm lowercaseString]];
    
    [NetworkController performRequestFor:searchUrl httpMethod:@"GET" urlParameters: nil body: nil completion:^(NSData *data, NSError *error) {
        
        // We can get back 2 things, error || data
        
        if (error) {
            NSLog(@"Erro getting pokemon from search term: %@", (error.localizedDescription));
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error getting returned data from task");
            completion(nil);
            return;
        }
        
        // Getting the jsonDictionary and serializeing a Pokemon
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&error]; // wants the address of the error 
        
        // JUST for the devloper
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Could not serilize JSON data inot a NSDictionary %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        Pokemon *pokemon = [[Pokemon alloc] initWithDictionary:jsonDictionary];
        
        completion(pokemon);
        
    }];
}

@end
