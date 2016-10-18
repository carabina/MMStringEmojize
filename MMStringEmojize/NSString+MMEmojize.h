//
//  NSString+MMEmojize.h
//  MMStringEmojize
//
//  Created by 夏伟 on 2016/10/19.
//  Copyright © 2016年 夏伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMEmojize)

- (NSString *)mm_emojizedString;
+ (NSString *)mm_emojizedStringWithString:(NSString *)text;

- (NSString *)mm_aliasedString;
+ (NSString *)mm_aliasedStringWithString:(NSString *)text;

+ (NSDictionary *)mm_emojiForAliases;
+ (NSDictionary *)mm_aliaseForEmojis;

- (NSString *)mm_toAliase;
- (NSString *)mm_toEmoji;

@end
