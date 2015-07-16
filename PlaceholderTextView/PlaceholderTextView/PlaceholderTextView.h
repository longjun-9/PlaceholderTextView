//
//  PlaceholderTextView.h
//
//  Created by longjun on 15/7/3.
//  Copyright (c) 2015年 longjun. All rights reserved.
//


/**
 *  PlaceholderTextView即可以用代码的方式创建，也可以用xib加载
 *  placeholder 所在的label，做了横竖屏适配
 *  测试了释放，确保该类不会导致内存泄露
 *  wordsNumLabel 是用来显示输入字数的label
 *  使用示例
    self.textView.placeholder=@"请输入xxxx阿达索朗多吉阿克琉斯的距离卡洛斯大家阿莱克斯多久阿萨德卡拉斯京的卡拉胶上地理课:1231123";
    self.textView.font=[UIFont boldSystemFontOfSize:12];
    self.textView.placeholderFont=[UIFont boldSystemFontOfSize:12];
    self.textView.layer.borderWidth=0.5;
    self.textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.textView.placeholderColor=[UIColor redColor];
    self.textView.maxTextLength = 10;
    [self.view addSubview:self.textView];
    self.wordsNumLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)0, (long)self.textView.maxTextLength];
 
    __weak typeof (self) weakSelf = self;
    [self.textView addTextDidChangeEvent:^(PlaceholderTextView *textView) {
        typeof (self) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"%lu",(unsigned long)textView.text.length);
            NSUInteger limitedLenth = textView.text.length;
            if (limitedLenth > textView.maxTextLength) {
                limitedLenth = textView.maxTextLength;
            }
            strongSelf.wordsNumLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)limitedLenth, (long)textView.maxTextLength];
        }
 
    }];
 */


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
