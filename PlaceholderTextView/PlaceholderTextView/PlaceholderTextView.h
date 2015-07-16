//
//  PlaceholderTextView.h
//
//  Created by longjun on 15/7/3.
//  Copyright (c) 2015年 longjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property(copy, nonatomic)   NSString *placeholder;
@property(strong, nonatomic) UIColor *placeholderColor;
@property(strong, nonatomic) UIFont * placeholderFont;

/**
 *  最大输入字限制
 */
@property(assign, nonatomic) NSInteger maxTextLength;

@property(strong, nonatomic) UILabel *placeholderLabel;

/**
 *  增加文字改变回调
 *
 *  @param textDidChange 文字改变回调
 *
 *  注意：在block里要使用weak-strong dance
 */
-(void)addTextDidChangeEvent:(void (^)(PlaceholderTextView *))textDidChange;

@end
