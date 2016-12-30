//
//  XNLiveViewController.m
//  XNLiveAppDemo
//
//  Created by xingnvlang on 16/12/9.
//  Copyright © 2016年 xuning. All rights reserved.
//

#import "XNLiveViewController.h"
#import <AlivcLiveVideo/AlivcLiveVideo.h>


@interface XNLiveViewController ()<AlivcLiveSessionDelegate>
//config配置类
@property (nonatomic, strong) AlivcLConfiguration *configuration;
//直播session
@property (nonatomic, strong) AlivcLiveSession *liveSession;
@end

@implementation XNLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfiguration];
    [self setupLiveSession];
}


// 设置直播参数
- (void)setupConfiguration {
    
    //1.初始化config配置类
    self.configuration = [[AlivcLConfiguration alloc]init];
    //2. 设置推流地址
    self.configuration.url = self.pushUrl;
    //3. 设置最大码率
    /*!
     *  最大码率，网速变化的时候会根据这个值来提供建议码率
     *  默认 1500 * 1000
     */
    self.configuration.videoMaxBitRate = 1500 * 1000;
    //4. 设置当前视频码率
    /*!
     *  默认码率，在最大码率和最小码率之间
     *  默认 600 * 1000
     */
    self.configuration.videoBitRate = 600 * 1000;
    //5. 设置最小码率
    /*!
     *  默认码率，在最大码率和最小码率之间
     *  默认 600 * 1000
     */
    self.configuration.videoMinBitRate = 400 * 1000;
    //6. 设置音频码率
    /*!
     *  音频码率
     *  默认 64 * 1000
     */
    self.configuration.audioBitRate = 64 * 1000;
    //7. 设置直播分辨率
    self.configuration.videoSize = CGSizeMake(360, 640);
    //8. 设置横屏or竖屏 默认竖屏
    self.configuration.screenOrientation = AlivcLiveScreenVertical;
    //9. 设置帧率 default 20
    self.configuration.fps = 20;
    //10. 设置摄像头采集质量
    self.configuration.preset = AVCaptureSessionPresetiFrame1280x720;
    //11. 设置前置摄像头或后置摄像头
    self.configuration.position = AVCaptureDevicePositionBack;
    //12.设置水印图片 默认无水印
    self.configuration.waterMaskImage = [UIImage imageNamed:@"watermask"];
    //13.设置水印位置
    self.configuration.waterMaskLocation = 1;
    //14.设置水印相对x边框距离
    self.configuration.waterMaskMarginX = 10;
    //15.设置水印相对y边框距离
    self.configuration.waterMaskMarginY = 10;
    //16.设置重连超时时长
    self.configuration.reconnectTimeout = 5;

}

- (void)setupLiveSession {
    
    //1. 初始化liveSession类
    self.liveSession = [[AlivcLiveSession alloc]initWithConfiguration:self.configuration];
    //2. 设置session代理
    self.liveSession.delegate = self;
    //3. 开启直播预览
    [self.liveSession alivcLiveVideoStartPreview];
    //4. 推流连接
    [self.liveSession alivcLiveVideoConnectServer];
    
    //5. 非常重要
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view insertSubview:[self.liveSession previewView] atIndex:0];
    });


}

// 关闭直播
- (void)destroySession{
    
    [self.liveSession alivcLiveVideoDisconnectServer];
    
    [self.liveSession alivcLiveVideoStopPreview];
    [self.liveSession.previewView removeFromSuperview];
    self.liveSession = nil;
}


/*!
 * 推流错误
 */
- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session error:(NSError *)error {

}

/*!
 * 网络很慢，已经不建议直播
 */
- (void)alivcLiveVideoLiveSessionNetworkSlow:(AlivcLiveSession *)session {


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)close:(UIButton *)sender {
    [self destroySession];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
