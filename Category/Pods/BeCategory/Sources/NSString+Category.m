//
//  NSString+Category.m
//  
//
//  Created by beinie on 15/7/2.
//
//
#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>



@implementation NSString (Category)

#pragma mark - Validations

- (BOOL)isNull {
    
    if(self == nil || [self isKindOfClass:[NSNull class]] || [self isEmpty]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isEmpty {
    return [[self trimWhitespace] isEqualToString:@""];
}


- (BOOL)isEmail {
    
    //Create a regex string
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" ;
    //Create predicate with format matching your regex string
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    //return true if email address is valid
    return [emailTest evaluateWithObject:self];
    
}

- (BOOL)isStartsWithACapitalLetter {
    
    unichar firstCharacter = [self characterAtIndex:0];
    return [[NSCharacterSet uppercaseLetterCharacterSet]
            characterIsMember:firstCharacter];
    
}

#pragma mark -

- (NSString *)trimWhitespace {
    
    //    NSMutableString *str = [self mutableCopy];
    //    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    //    return str;
    
    return [self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)numberOfWords {
    __block NSUInteger count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByWords|NSStringEnumerationSubstringNotRequired
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              count++;
                          }];
    return count;
}

- (NSString *)reverseString {
    
    //    int len = [self length];
    //
    //    NSMutableString *reversedStr = [NSMutableString stringWithCapacity:len];
    //    while (len--) {
    //        [reversedStr appendFormat:@"%C", [self characterAtIndex:len]];
    //    }
    
    // New way
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0,[self length])
                             options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              [reversedString appendString:substring];
                          }];
    
    
    return reversedString;
}

- (NSString *)concat:(NSString *)string {
    
    if (!string) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@",self, string];
}

- (BOOL)contains:(NSString *)string {
    
    if (string) {
        NSRange range = [self rangeOfString:string];
        return (range.location != NSNotFound);
        
    }else {
        return NO;
    }
    
}


+ (NSString *)truncateString:(NSString *) string toCharacterCount:(NSUInteger) count {
    
    NSRange range = { 0, MIN(string.length, count) };
    range = [string rangeOfComposedCharacterSequencesForRange: range];
    NSString *trunc = [string substringWithRange: range];
    
    if (trunc.length < string.length) {
        trunc = [trunc stringByAppendingString: @"..."];
    }
    
    return trunc;
    
} // truncateString

#pragma mark - URL Encoding and Decoding

- (NSString *)MD5{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (int)(strlen(original_str)), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
//- (NSString *)urlEncode {
//    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
//}
//
//- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
//                                                                                 (__bridge CFStringRef)self,
//                                                                                 NULL,
//                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
//                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
//}
//
//- (NSString *)stringUTF8Decode {
//    return [self stringUsingEncoding:NSUTF8StringEncoding];
//}
//
//- (NSString *)stringUsingEncoding:(NSStringEncoding)encoding {
//    
//    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                                                                             (CFStringRef)self, CFSTR(""),  kCFStringEncodingUTF8));
//    
//    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                 (__bridge CFStringRef)self,
//                                                                                                 CFSTR(""),
//                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
//}



#pragma mark - Date Format

- (NSDate *)dateFromFormat: (NSString *)formatter {
    
    //    debug(@"dateString %@",dateString);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:formatter];
    
    NSDate *dateFromString = [dateFormatter dateFromString:self];
    return dateFromString;
}
+ (NSString *)getSmallImagestringFromString:(NSString *)str {
    NSArray *arr = [str componentsSeparatedByString:@"/"];
    NSMutableArray *marr = [NSMutableArray new];
    for (int i = 0; i < arr.count; i++) {
        if (i == arr.count - 1) {
            NSString *s = arr[i];
            NSString *newStr = [NSString stringWithFormat:@"thumb_%@", s];
            [marr addObject:newStr];
            break;
        }
        [marr addObject:arr[i]];
    }
    return [marr componentsJoinedByString:@"/"];
}

//字母数字下划线组成的中文字段
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}


//根据字符串的字体和size(此处size设置为字符串宽和MAXFLOAT)返回多行显示时的字符串size
//- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size {
//    
//    CGSize resultSize;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
//        //段落样式
//        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//        style.lineBreakMode = NSLineBreakByWordWrapping;
//        
//        //字体大小，换行模式
//        NSDictionary *attributes = @{NSFontAttributeName : font , NSParagraphStyleAttributeName : style};
//        resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    } else {
//        //计算正文的高度
//        
//        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//    }
//    return resultSize;
//}

//判断手机号码
- (BOOL)validateMobile
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|7[0-9])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark 只能输入数字
- (BOOL)onlyNum {
    
    NSCharacterSet *cs;
    NSString *strNum = @"1234567890.";
    cs = [[NSCharacterSet characterSetWithCharactersInString:strNum] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [self isEqualToString:filtered];
    
    return  basic;
}


//邮箱
- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


//身份证号
-(BOOL) validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
+(BOOL)compareVersion:(NSString*)oldVersion newVersion:(NSString*)newVersion{
    return [oldVersion compare:newVersion options:NSNumericSearch] == NSOrderedDescending;
}

- (NSString *)huansuan {
    float i = [self floatValue];
    if (i>=10000) {
        i = i/10000;
        return [NSString stringWithFormat:@"%.f万",i];
    } else {
        return self;
    }
}


- (NSAttributedString *)styleWithColor:(UIColor *)color andRange:(NSRange)range andFont:(UIFont *)font {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    [str addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, str.length)];
    [str addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    return str;
}


//处理银行卡号
- (NSString *)banccode {
    NSString *str1 = @"";
    for (NSInteger i = 0; i < self.length - 6; i ++) {
        str1 = [NSString stringWithFormat:@"%@*",str1];
    }
    NSString *codeStr = [NSString stringWithFormat:@"%@%@%@",[self substringToIndex:2],str1,[self substringWithRange:NSMakeRange(self.length - 4, 4)]];
    return codeStr;
}


@end
