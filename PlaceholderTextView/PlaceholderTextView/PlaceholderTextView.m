//
//  PlaceholderTextView.m
//
//  Created by longjun on 15/7/3.
//  Copyright (c) 2015年 longjun. All rights reserved.
//

#import "PlaceholderTextView.h"
@interface PlaceholderTextView()<UITextViewDelegate>

@property(assign,nonatomic) float placeholdeWidth;

@property(copy,nonatomic) void (^eventBlock)(PlaceholderTextView *);


@end

#define kPlaceholderTopMargin  8.0


@implementation PlaceholderTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNoti:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditingNoti:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditingNoti:) name:UITextViewTextDidEndEditingNotification object:self];
    
    float left=5,top=kPlaceholderTopMargin;
    
    /**
     *  默认设置
     */
    _placeholdeWidth=CGRectGetWidth(self.frame)-2*left;
    _placeholderColor = [UIColor lightGrayColor];
    _placeholderFont = self.font;
    _maxTextLength = 1000;
    
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top, _placeholdeWidth, self.frame.size.height - 2*top)];
    _placeholderLabel.numberOfLines = 0;
    _placeholderLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _placeholderLabel.textColor = _placeholderColor;
    _placeholderLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    if (self.text.length > 0) {
        _placeholderLabel.hidden=YES;
    }
    
    [self addSubview:_placeholderLabel];
}

- (float)boundingRectWithSize:(CGSize)size withFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [_placeholder boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    
    
    return retSize.height;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    /**
     *  layout时获取真实值
     */
    _placeholderLabel.font =  _placeholderFont;
    _placeholderLabel.textColor= _placeholderColor;
    _placeholderLabel.text= _placeholder;

    float chosenHeight = 0;
    float leftHeight = CGRectGetHeight(self.frame)-kPlaceholderTopMargin;
    float height=  [self boundingRectWithSize:CGSizeMake(_placeholderLabel.frame.size.width, MAXFLOAT) withFont:_placeholderLabel.font];
    /**
     *  chosenHeight不能超过leftHeight
     */
    if (height > leftHeight)
    {
        CGFloat lineHeight = _placeholderLabel.font.lineHeight;
        NSInteger lines = floorf(leftHeight/lineHeight);
        chosenHeight = lines * lineHeight;

    }
    else
    {
        chosenHeight = height;
    }

    CGRect frame=_placeholderLabel.frame;
    frame.size.height=chosenHeight;
    _placeholderLabel.frame=frame;
    
    
}


#pragma mark---一些通知
-(void)textViewTextDidChangeNoti:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _placeholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _placeholderLabel.hidden=YES;
    }
    else{
        _placeholderLabel.hidden=NO;
    }
    
    if (self.markedTextRange == nil) {
        if (_eventBlock) {
            _eventBlock(self);
        }
    }
    
    if (_maxTextLength > 0 && self.text.length > _maxTextLength && self.markedTextRange == nil) {
        self.text = [self.text substringWithRange: NSMakeRange(0, _maxTextLength)];
    }
}

-(void)textDidBeginEditingNoti:(NSNotification*)noti {
    _placeholderLabel.hidden=YES;
}

-(void)textDidEndEditingNoti:(NSNotification*)noti {
    if (self.text.length == 0 || [self.placeholder isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
    }
}



#pragma mark----使用block 代理 delegate
-(void)addTextDidChangeEvent:(void (^)(PlaceholderTextView *))textDidChange {
    if (textDidChange) {
        _eventBlock=textDidChange;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_placeholderLabel removeFromSuperview];
    
}

@end
