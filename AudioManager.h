//
//  AudioManager.h
//  AVAuSettingDemo
//
//  Created by chenfan on 2020/6/24.
//  Copyright © 2020 suhengxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioManager : NSObject
@property(nonatomic,strong) AVAudioSession *avaudioSession;

+(instancetype)manager;

-(void)getPermisssionSuccess:(void(^)(void))success fail:(void(^)(void))fail;

-(void)currentOutPuts;

-(BOOL)isBleOutput;

-(BOOL)turnToA2DPMode;


@end

NS_ASSUME_NONNULL_END
