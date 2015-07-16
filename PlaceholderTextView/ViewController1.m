//
//  ViewController1.m
//
//  Created by longjun on 15/7/15.
//  Copyright (c) 2015年 longjun. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"

@implementation ViewController1

- (IBAction)btnClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ViewController2 *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
