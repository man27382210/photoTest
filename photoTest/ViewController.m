//
//  ViewController.m
//  photoTest
//
//  Created by En on 12/12/31.
//  Copyright (c) 2012年 En. All rights reserved.
//

#import "ViewController.h"
#define SELF_HEIGHT_FOUR    self.view.frame.size.height/4
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[buttonMini imageView]setContentMode:UIViewContentModeCenter];
    [buttonMini setImage:[UIImage imageNamed:@"apple.jpg"] forState:UIControlStateNormal];
    viewBackground = [[UIView alloc]init];
    viewBackground.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    imageViewShow = [[UIImageView alloc]init];
    imageViewShow.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)showNewImage:(id)sender
{
    [imageViewShow setImage:[UIImage imageNamed:@"apple.jpg"]];
    [imageViewShow setContentMode:UIViewContentModeScaleAspectFill];
    [imageViewShow setCenter:self.view.center];
    [viewBackground setBackgroundColor:[UIColor blackColor]];
    [viewBackground addSubview:imageViewShow];
    [self.view addSubview:viewBackground];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject]locationInView:self.view];
    point.x = imageViewShow.center.x;
    UITouch *touch = touches.anyObject;
    float range = point.y - self.view.center.y;
    range = range/self.view.frame.size.height;
    if (range < 0)
    {
        range = -range;
    }
    if([touch view]==viewBackground)
    {
        [UIView animateWithDuration:0.1 animations:^{
            [imageViewShow setCenter:point];
            viewBackground.alpha = 1-range;
        }];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if([touch view] == viewBackground)
    {
        [UIView animateWithDuration:0.1 animations:^{
            if (imageViewShow.center.y > SELF_HEIGHT_FOUR*3 || imageViewShow.center.y < SELF_HEIGHT_FOUR)
            {
                [viewBackground removeFromSuperview];
                viewBackground.alpha = 1;
            }
            else
            {
                [imageViewShow setCenter:self.view.center];
                viewBackground.alpha = 1;
            }
        }];
    }
}
@end
