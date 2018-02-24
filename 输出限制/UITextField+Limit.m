//
//  UITextField+Limit.m
//  输出限制
//
//  Created by pc-005 on 2018/2/11.
//  Copyright © 2018年 lishuang. All rights reserved.
//

#import "UITextField+Limit.h"
#import <objc/runtime.h>

@implementation UITextField (Limit)

static char limit;

- (void)setLimitNum:(NSInteger)limitNum
{
    objc_setAssociatedObject(self, &limit, @(limitNum), OBJC_ASSOCIATION_RETAIN);
    [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)limitNum {
    NSNumber * ob = objc_getAssociatedObject(self, &limit);
    return ob.integerValue;
}


- (void)textFieldEditChanged:(UITextField *)textField {
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            [self limitStrNum];
        }
    }
    
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        [self limitStrNum];
    }
    
}

- (void)limitStrNum
{
    if(self.limitNum == 0) return;
    
    if (self.text.length > self.limitNum) {
        self.text = [self.text substringToIndex:self.limitNum];
    }
}


@end

