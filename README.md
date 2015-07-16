# PlaceholderTextView
UITextView with placeholer and input with limited characters number.
1.PlaceholderTextView即可以用代码的方式创建，也可以用xib加载
2.placeholder 所在的label，做了横竖屏适配
3.测试了释放，确保该类不会导致内存泄露
4.wordsNumLabel 是用来显示输入字数的label
使用示例:

    self.textView.placeholder=@"请输入xxxx阿达索朗多吉阿克琉斯的距离卡洛斯大家阿莱克斯多久阿萨德卡拉斯京的卡拉胶上地理课:1231123";
    self.textView.font=[UIFont boldSystemFontOfSize:12];
    self.textView.placeholderFont=[UIFont boldSystemFontOfSize:12];
    self.textView.layer.borderWidth=0.5;
    self.textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.textView.placeholderColor=[UIColor redColor];
    self.textView.maxTextLength = 10;
    self.wordsNumLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)0, (long)self.textView.maxTextLength];
    [self.view addSubview:self.textView];
    
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
