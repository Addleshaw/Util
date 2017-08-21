//
//  NSString+Category.h
//
//
//  Created by beinie on 15/7/2.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Category)

#pragma mark - Validations

- (BOOL)isNull ;

- (BOOL)isEmpty ;

- (BOOL)isEmail ;

- (BOOL)isStartsWithACapitalLetter;

#pragma mark -

- (NSString *)trimWhitespace ;

- (NSUInteger)numberOfWords ;

- (NSString *)reverseString ;

- (NSString *)concat:(NSString *)string ;

- (BOOL)contains:(NSString *)string ;

+ (NSString *)truncateString:(NSString *) string toCharacterCount:(NSUInteger) count ;

+ (NSString *)getSmallImagestringFromString:(NSString *)str;
#pragma mark - URL Encoding and Decoding

- (NSString *)MD5;
//- (NSString *)urlEncode;
//
//- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding ;
//
//- (NSString *)stringUTF8Decode ;
//
//- (NSString *)stringUsingEncoding:(NSStringEncoding)encoding;

#pragma mark - Date Format

- (NSDate *)dateFromFormat: (NSString *)formatter ;


-(BOOL)isChinese;
//- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;
- (BOOL)validateMobile;
- (BOOL)onlyNum;
- (BOOL)validateEmail;
- (BOOL)validateIdentityCard;


+(BOOL)compareVersion:(NSString*)oldVersion newVersion:(NSString*)newVersion;

- (NSString *)huansuan;

- (NSAttributedString *)styleWithColor:(UIColor *)color andRange:(NSRange)range andFont:(UIFont *)font;


- (NSString *)banccode;
@end

