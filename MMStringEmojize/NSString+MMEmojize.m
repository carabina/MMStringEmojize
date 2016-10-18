//
//  NSString+MMEmojize.m
//  MMStringEmojize
//
//  Created by 夏伟 on 2016/10/19.
//  Copyright © 2016年 夏伟. All rights reserved.
//

#import "NSString+MMEmojize.h"
#import "emojis.h"

@implementation NSString (MMEmojize)

- (NSString *)mm_emojizedString {
    return [NSString mm_emojizedStringWithString:self];
}

+ (NSString *)mm_emojizedStringWithString:(NSString *)text {
    static dispatch_once_t onceToken;
    static NSRegularExpression *regex = nil;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"(:[a-z0-9-+_]+:)" options:NSRegularExpressionCaseInsensitive error:NULL];
    });
    
    __block NSString *resultText = text;
    NSRange matchingRange = NSMakeRange(0, [resultText length]);
    [regex enumerateMatchesInString:resultText options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
         if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
             NSRange range = result.range;
             if (range.location != NSNotFound) {
                 NSString *code = [text substringWithRange:range];
                 NSString *unicode = self.mm_emojiForAliases[code];
                 if (unicode) {
                     resultText = [resultText stringByReplacingOccurrencesOfString:code withString:unicode];
                 }
             }
         }
     }];
    
    return resultText;
}

- (NSString *)mm_aliasedString {
    return [NSString mm_aliasedStringWithString:self];
}

+ (NSString *)mm_aliasedStringWithString:(NSString *)text {
    if (!text || text.length <= 0) {
        return text;
    }
    __block NSString *resultText = text;
    [text enumerateSubstringsInRange:NSMakeRange(0, text.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (self.mm_aliaseForEmojis[substring]) {
            NSString *aliase = self.mm_aliaseForEmojis[substring];
            resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:aliase];
        }
    }];
    return resultText;
}

+ (NSDictionary *)mm_emojiForAliases {
    static NSDictionary *_emojiForAliases;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emojiForAliases = EMOJI_HASH;
    });
    return _emojiForAliases;
}

+ (NSDictionary *)mm_aliaseForEmojis {
    static NSMutableDictionary *_aliaseForEmojis;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _aliaseForEmojis = [[NSMutableDictionary alloc] init];
        [[self mm_emojiForAliases] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [_aliaseForEmojis setObject:key forKey:obj];
        }];
    });
    return _aliaseForEmojis;
}

- (NSString *)mm_toAliase {
    return self.class.mm_aliaseForEmojis[self];
}

- (NSString *)mm_toEmoji {
    return self.class.mm_emojiForAliases[self];
}

@end
