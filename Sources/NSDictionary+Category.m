//
//  NSDictionary+Category.m
//
//
//  Created by beinie on 15/7/2.
//
//
#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)


-(NSString*)josnUTF8String{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:nil] encoding:NSUTF8StringEncoding];
}

-(NSString*)toString{
    NSMutableArray *arr= [NSMutableArray new];
    for (NSString*s in self.allKeys) {
        if ([[self objectForKey:s] isKindOfClass:[NSDictionary class]]) {
            NSDictionary*dic = [self objectForKey:s];
            [arr addObject:[NSString stringWithFormat:@"%@:%@",s,[dic toString]]];
        }else{
            [arr addObject:[NSString stringWithFormat:@"%@:%@",s,[self stringFromKey:s]]];
        }
    }
    return [NSString stringWithFormat:@"{%@}",[arr componentsJoinedByString:@","]];
}

-(NSString*)stringFromKey:(NSString*)key{
    if ([self objectForKey:key]&&[[self objectForKey:key] isEqual:[NSNull null]]) {
        return @"";
    }else if([self objectForKey:key]&&[[self objectForKey:key] isKindOfClass:[NSNumber class]]){
        int i = [self[key] intValue];
        double f = [self[key] doubleValue];
        
        //NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
        //[moneyFormatter setPositiveFormat:@"###,##0.000;"];
        if (i==f) {
            return [NSString stringWithFormat:@"%i",i];
        }else{
            return [NSString stringWithFormat:@"%.2f",f];
        }
    }else if([self objectForKey:key]){
        return [NSString stringWithFormat:@"%@",[self objectForKey:key]];
    }else{
        return @"";
    }
}

-(NSDictionary*)dicFromKey:(NSString*)key{
    if ([self objectForKey:key]&&[[self objectForKey:key] isEqual:[NSNull null]]) {
        return @{};
    }else if([self objectForKey:key]&&[[self objectForKey:key] isKindOfClass:[NSDictionary class]]){
        return [self objectForKey:key];
    }else{
        return @{};
    }
    //    return [self anyObjectForKey:key withNilBlock:^id() {
    //        return @"";
    //    }];
}
-(NSMutableArray *)mutableArrayForKey:(NSString *)key{
    NSMutableArray*arr = [NSMutableArray new];
    if ([self objectForKey:key]&&[[self objectForKey:key] isEqual:[NSNull null]]) {
        return arr;
    }else if([[self objectForKey:key] isKindOfClass:[NSArray class]]){
        [arr addObjectsFromArray:[self objectForKey:key]];
        return arr;
    }else{
        return arr;
    }
}
-(NSArray *)arrayForKey:(NSString *)key{
    if ([self objectForKey:key]&&[[self objectForKey:key] isEqual:[NSNull null]]) {
        return @[];
    }else if([[self objectForKey:key] isKindOfClass:[NSArray class]]){
        return [self objectForKey:key];
    }else{
        return @[];
    }
}
-(NSArray *)dicArrayForKey:(NSString *)key{
    if ([self objectForKey:key]&&[[self objectForKey:key] isEqual:[NSNull null]]) {
        return @[];
    }else if([[self objectForKey:key] isKindOfClass:[NSArray class]]){
        NSMutableArray*arr = [NSMutableArray new];
        for (id item in [self objectForKey:key]) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [arr addObject:item];
            }
        }
        return arr;
    }else{
        return @[];
    }
}
-(NSNumber*)numberForKey:(NSString *)key{
    return [self anyObjectForKey:key withNilBlock:^id{
        return @0;
    }];
}

-(NSMutableDictionary*)dictionaryForKey:(NSString*)key{
    
    return [[self anyObjectForKey:key withNilBlock:^id{
        return [NSDictionary new];
    }] mutableCopy];
}

-(BOOL)isArrayOfKey:(NSString*)key{
    return [[self objectForKey:key] isKindOfClass:[NSArray class]];
}
-(BOOL)isNotEmptyArrayOfKey:(NSString*)key{
    return [[self objectForKey:key] isKindOfClass:[NSArray class]]&&((NSArray*)[self objectForKey:key]).count>0;
}


-(BOOL)isStringOfKey:(NSString*)key{
    return [[self objectForKey:key] isKindOfClass:[NSString class]];
}
-(BOOL)isNotEmptyStringOfKey:(NSString*)key{
    return [[self objectForKey:key] isKindOfClass:[NSString class]]&&((NSString*)[self objectForKey:key]).length>0;
}


-(BOOL)isDictionaryOfKey:(NSString*)key{
    return [[self objectForKey:key] isKindOfClass:[NSDictionary class]];
}
-(BOOL)isNotEmptyDictionaryOfKey:(NSString*)key{
    return [[self objectForKey:key] isKindOfClass:[NSDictionary class]]&&((NSDictionary*)[self objectForKey:key]).allKeys.count>0;
}


-(id)anyObjectForKey:(NSString*)key withNilBlock:(id(^)())block{
    return [[self objectForKey:key] isKindOfClass:[block() class]]?[self objectForKey:key]:block();
}



@end
