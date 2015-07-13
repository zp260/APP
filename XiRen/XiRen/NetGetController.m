//
//  NetGetController.m
//  XiRen
//
//  Created by PIPI on 15/7/3.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "NetGetController.h"

@interface NetGetController ()

@end

@implementation NetGetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) AFgetOLdata:(NSString *)ApiUrlString backArray:(NSMutableArray *)backArray
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:ApiUrlString parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //传递返回数据
         
         
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"出错了" message:@"请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         NSLog(@"json:%@",error);
         
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
