//
//  ViewController2.m
//
//  Created by longjun on 15/7/16.
//  Copyright (c) 2014年 longjun. All rights reserved.
//

#import "ViewController2.h"
#import "PlaceholderTextView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRGB(R,G,B)       [UIColor colorWithRed:R/255.f green:G/255.f blue:254/255.f alpha:1];



@interface ViewController2 () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *phTv;

@end

@implementation ViewController2


- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
                       
    self.view.backgroundColor=kRGB(32, 152, 237);
    
    self.phTv.placeholder = @"请输入xxxx阿达索朗多吉阿克琉斯的距离卡洛斯大家阿莱克斯多久阿萨德卡拉斯京的卡拉胶上地理课:1231123";
    self.phTv.font=[UIFont boldSystemFontOfSize:12];
    self.phTv.placeholderFont=[UIFont boldSystemFontOfSize:12];
    self.phTv.layer.borderWidth=0.5;
    self.phTv.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.phTv.placeholderColor=[UIColor redColor];
    self.phTv.maxTextLength = 10;
    [self.view addSubview:self.phTv];
    self.label1.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)0, (long)self.phTv.maxTextLength];
    
    __weak typeof (self) weakSelf = self;
    [self.phTv addTextDidChangeEvent:^(PlaceholderTextView *text) {
        typeof (self) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"%lu",(unsigned long)text.text.length);
            NSUInteger limitedLenth = text.text.length;
            if (limitedLenth > text.maxTextLength) {
                limitedLenth = text.maxTextLength;
            }
            strongSelf.label1.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)limitedLenth, (long)text.maxTextLength];
        }

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCliked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self addDoneToolBarToKeyboard:textView];
    return YES;
}

-(void)addDoneToolBarToKeyboard:(UITextView *)textView
{
    if (textView.inputAccessoryView == nil) {
        UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        doneToolbar.barStyle = UIBarStyleDefault;
        doneToolbar.items = [NSArray arrayWithObjects:
                             [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)],
                             nil];
        [doneToolbar sizeToFit];
        textView.inputAccessoryView = doneToolbar;
    }
}

-(void)doneButtonClickedDismissKeyboard
{
    [self.phTv resignFirstResponder];
}

@end
