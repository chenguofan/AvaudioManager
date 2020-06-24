//
//  AudioManager.m
//  AVAuSettingDemo
//
//  Created by chenfan on 2020/6/24.
//  Copyright © 2020 suhengxian. All rights reserved.
//

#import "AudioManager.h"

@interface AudioManager ()

@end

@implementation AudioManager

-(instancetype)init{
    if (self = [super init]) {
        _avaudioSession = [AVAudioSession sharedInstance];
    }
    return self;
}

+(instancetype)manager{
    static AudioManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AudioManager alloc] init];
    });
    return manager;
}

-(void)getPermisssionSuccess:(void(^)(void))success fail:(void(^)(void))fail{
    [self.avaudioSession requestRecordPermission:^(BOOL granted) {
        if (granted == YES) {
            
            NSError *error = nil;
            
            [self.avaudioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionAllowBluetoothA2DP error:nil];
            
            
            if (error) {
                NSLog(@"麦克风:%@",error);
                if (fail) {  //获取录音权限失败
                    fail();
                }
            } else {
                if (success) {
                    success();
                }
            }
        }else{
            if (fail) {  //没有获取录音的权限
                fail();
            }
         }
    }];
}

-(void)currentOutPuts{
      AVAudioSessionRouteDescription *currentRount = self.avaudioSession.currentRoute;
      NSLog(@"currentRount.outputs:%@",currentRount.outputs);
      
      if (currentRount.outputs.count >0) {
          AVAudioSessionPortDescription *outputPortDesc = currentRount.outputs[0];
          NSLog(@"当前输出的线路是==%@",outputPortDesc.portType);
      }
}

-(BOOL)turnToA2DPMode{
     NSError *err;
    
    [self.avaudioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionAllowBluetoothA2DP error:nil];
    
     [self.avaudioSession setActive:YES error:&err];
     
     if(err){
         NSLog(@"AV Audio Session setactive to YES error = %@", err);
         return NO;
     }
     
     NSLog(@"AV Audio Session to A2DP YES");
     return YES;
}

-(BOOL)isBleOutput{
       AVAudioSessionRouteDescription *currentRount = self.avaudioSession.currentRoute;
       if (currentRount.outputs.count >0) {
           AVAudioSessionPortDescription *outputPortDesc = currentRount.outputs[0];
           if([outputPortDesc.portType isEqualToString:@"BluetoothA2DPOutput"]){

                NSLog(@"当前输出的线路是蓝牙输出，并且已连接");
                return YES;
           }else{

                NSLog(@"当前是spearKer输出");
                return NO;
            }
       }
      return NO;
}



@end
