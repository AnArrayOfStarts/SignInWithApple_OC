//
//  NativeSignAppleModule.m
//  SecondDemo
//
//  Created by 李晓龙 on 2019/11/27.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "NativeSignAppleModule.h"
#import "AppDelegate.h"


@interface NativeSignAppleModule()
/// 返回callback
@property (nonatomic, copy) RCTResponseSenderBlock dataCallback;

@end

@implementation NativeSignAppleModule



/** 声明名字 */
RCT_EXPORT_MODULE();

/** 声明方法 微信第三方登录 */
RCT_EXPORT_METHOD(isIOSThirteen:(RCTResponseSenderBlock)callback)
{
  if (@available(iOS 13.0, *)) {
    callback(@[@{@"code":@0,@"data":@"ios版本大于13"}]);
  }
  else{
    callback(@[@{@"code":@-1,@"error_msg":@"ios版本小于13"}]);
  }
}


/** 声明方法 微信第三方登录 */
RCT_EXPORT_METHOD(signApple:(RCTResponseSenderBlock)callback)
{
  NSLog(@"调用方法");
  self.dataCallback =callback;
  if (@available(iOS 13.0, *)) {
      // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
      ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
      // 创建新的AppleID 授权请求
      ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
      // 在用户授权期间请求的联系信息
      appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
      // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
      ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
      // 设置授权控制器通知授权请求的成功与失败的代理
      authorizationController.delegate = self;
      // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
      authorizationController.presentationContextProvider = self;
      // 在控制器初始化期间启动授权流
      [authorizationController performRequests];
  }
}

#pragma mark delegate
//@optional 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    NSLog(@"授权完成:::%@", authorization.credential);
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", controller);
    NSLog(@"%@", authorization);
    
    // 测试配置UI显示
//    NSMutableString *mStr = [NSMutableString string];
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; // access token
//        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        // TODO 网络返回 传递 identityToken 等需要的信息
      
      NSMutableDictionary *dataDic = @{
        @"state":[NSString stringWithFormat:@"%@",state],
        @"userID":userID,
        @"familyName":fullName.familyName,
        @"givenName":fullName.givenName,
        @"email":email,
        @"authorizationCode":authorizationCode,
        @"identityToken":identityToken,
      }.mutableCopy;
      
      // 传递回去
      self.dataCallback(@[@{@"code":@0,@"data":dataDic}]);
      

    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // 使用现有密码凭证，暂不考虑。
        self.dataCallback(@[@{@"code":@-1,@"error_msg":@"密码凭证验证"}]);
    }else{
        // 授权信息均不符
        self.dataCallback(@[@{@"code":@-1,@"error_msg":@"授权信息均不符"}]);
    }
}

// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    // Handle error.
    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
            
        default:
            break;
    }
    // TODO 提示用户请求失败
  self.dataCallback(@[@{@"code":@-1,@"error_msg":errorMsg}]);
    
}


// 告诉代理应该在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    // 返回window
    return (UIWindow *)self;
}


@end
