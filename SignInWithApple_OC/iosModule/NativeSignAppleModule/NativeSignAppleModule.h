//
//  NativeSignAppleModule.h
//  SecondDemo
//
//  Created by 李晓龙 on 2019/11/27.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativeSignAppleModule : NSObject<RCTBridgeModule,ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@end

NS_ASSUME_NONNULL_END
