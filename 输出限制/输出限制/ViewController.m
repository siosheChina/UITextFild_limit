//
//  ViewController.m
//  输出限制
//
//  Created by pc-005 on 2018/2/11.
//  Copyright © 2018年 lishuang. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Limit.h"
@interface ViewController ()<UITextFieldDelegate> {
    UITextField *_editTextField;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextField *textField1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    外面调用只有这一行代码，与代理方法不冲突
    self.textField.limitNum = 5;
    self.textField1.limitNum = 10;
 

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _editTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _editTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_editTextField resignFirstResponder];
}

@end
