//
//  ViewController.m
//  XNLiveAppDemo
//
//  Created by xingnvlang on 16/12/9.
//  Copyright © 2016年 xingnvlang. All rights reserved.
//

#import "ViewController.h"
#import "XNLiveViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pushURLTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)starLive:(UIButton *)sender {
    XNLiveViewController *live = [[XNLiveViewController alloc]init];
    live.pushUrl = self.pushURLTextField.text;
    [self presentViewController:live animated:YES completion:nil];
}


@end
