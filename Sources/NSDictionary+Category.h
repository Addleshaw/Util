//
//  NSDictionary+Category.h
//
//
//  Created by beinie on 15/7/2.
//
//
#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

-(NSString*)josnUTF8String;

-(NSString*)toString;

-(NSString*)stringFromKey:(NSString*)key;
-(NSDictionary*)dicFromKey:(NSString*)key;

-(NSMutableArray*)mutableArrayForKey:(NSString *)key;

-(NSArray*)arrayForKey:(NSString *)key;

-(NSArray *)dicArrayForKey:(NSString *)key;

-(NSNumber*)numberForKey:(NSString *)key;

-(NSMutableDictionary*)dictionaryForKey:(NSString*)key;

-(BOOL)isArrayOfKey:(NSString*)key;
-(BOOL)isNotEmptyArrayOfKey:(NSString*)key;

-(BOOL)isStringOfKey:(NSString*)key;
-(BOOL)isNotEmptyStringOfKey:(NSString*)key;

-(BOOL)isDictionaryOfKey:(NSString*)key;
-(BOOL)isNotEmptyDictionaryOfKey:(NSString*)key;



@end
