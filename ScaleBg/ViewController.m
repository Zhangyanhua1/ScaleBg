//
//  ViewController.m
//  ScaleBg
//
//  Created by 云书网 on 16/8/8.
//  Copyright © 2016年 云书网. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIView*  popView;
@property (nonatomic,strong) UIView* maskView;

#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(bounced) forControlEvents:UIControlEventTouchUpInside];
    
    [self createview];
    
}
-(void)createview
{
    _popView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0f)];
    _popView.backgroundColor = [UIColor colorWithRed:1.000 green:0.988 blue:0.960 alpha:1.000];
    // 标题
   UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"选择类型";
    [_popView addSubview:titleLabel];
    
    _maskView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
    _maskView.alpha = 0.0f;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [_maskView addGestureRecognizer:tapGesture];
}



//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.transform = [self firstStepTransform];
        self.popView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.layer.transform = CATransform3DIdentity;
            self.maskView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
            [self.popView removeFromSuperview];
        }];
    }];
}
-(void)bounced
{
      [self open];
}
- (void)open {
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
      [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    [UIView animateWithDuration:0.2 animations:^{
        self.view.layer.transform = [self firstStepTransform];
        self.maskView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.layer.transform = [self secondStepTransform];
            self.popView.transform = CGAffineTransformTranslate(self.popView.transform, 0, -SCREEN_HEIGHT / 2.0f);
        }];
    }];
}
// 动画1
- (CATransform3D)firstStepTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0; //透视效果
//    transform = CATransform3DScale(transform, 0.98, 0.98, 1.0);
//    transform = CATransform3DRotate(transform, 5.0 * M_PI / 180.0, 1, 0, 0); //制造旋转矩阵，控制旋转角度和方向。这里有一个诀窍就是向量值某个坐标值的正负影响向量的指向方向也影响视图的旋转方向。
    transform = CATransform3DTranslate(transform, 0, 0, -30.0);
    return transform;
}

// 动画2
- (CATransform3D)secondStepTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self firstStepTransform].m34;
    transform = CATransform3DTranslate(transform, 0, SCREEN_HEIGHT * -0.08, 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
    return transform;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
