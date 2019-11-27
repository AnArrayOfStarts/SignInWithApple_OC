//
//  LXLMainViewController.m
//  SignInWithApple_OC
//
//  Created by 李晓龙 on 2019/11/25.
//  Copyright © 2019 LXL. All rights reserved.
//

#import "LXLMainViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface LXLMainViewController ()<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
/// 滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
/// 展示label
@property (nonatomic, strong) UILabel *showMsgLabel;
/// 点击登录按钮
@property (nonatomic, strong) ASAuthorizationAppleIDButton *loginBtn1;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *loginBtn2;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *loginBtn3;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *loginBtn4;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *loginBtn5;

@end

@implementation LXLMainViewController

#pragma mark - View

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 配置UI
    [self config_UI];
    // 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
    [self perfomExistingAccountSetupFlows];
}

#pragma mark - Private
/// 配置UI
-(void)config_UI{
    [self.view addSubview:self.loginBtn1];
    [self.view addSubview:self.loginBtn2];
    [self.view addSubview:self.loginBtn3];
    [self.view addSubview:self.loginBtn4];
    [self.view addSubview:self.loginBtn5];
    [self.view addSubview:self.scrollView];
    

}
// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
- (void)perfomExistingAccountSetupFlows{
    NSLog(@"///已经认证过了/////");
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 授权请求AppleID
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 为了执行钥匙串凭证分享生成请求的一种机制
        ASAuthorizationPasswordProvider *passwordProvider = [[ASAuthorizationPasswordProvider alloc] init];
        ASAuthorizationPasswordRequest *passwordRequest = [passwordProvider createRequest];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest, passwordRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }
}


#pragma mark - Public

#pragma mark - Event
// 处理授权
- (void)handleAuthorizationAppleIDButtonPress{
    NSLog(@"////////");
        
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

#pragma mark - set

#pragma mark - lazy

/// 默认样式+白色底
- (ASAuthorizationAppleIDButton *)loginBtn1{
    if (!_loginBtn1) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        appleIDBtn.frame = CGRectMake(30, 100, self.view.bounds.size.width - 60, 40);
//            appleIDBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn1 =appleIDBtn;
    }
    return _loginBtn1;
}

/// sigin + 白色底部黑色边框
- (ASAuthorizationAppleIDButton *)loginBtn2{
    if (!_loginBtn2) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeSignIn style:ASAuthorizationAppleIDButtonStyleWhiteOutline];
        appleIDBtn.frame = CGRectMake(30, 150, self.view.bounds.size.width - 60, 40);
//            appleIDBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn2 =appleIDBtn;
    }
    return _loginBtn2;
}

/// continue + 黑底
- (ASAuthorizationAppleIDButton *)loginBtn3{
    if (!_loginBtn3) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeContinue style:ASAuthorizationAppleIDButtonStyleBlack];
        appleIDBtn.frame = CGRectMake(30, 200, self.view.bounds.size.width - 60, 40);
//            appleIDBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn3 =appleIDBtn;
    }
    return _loginBtn3;
}

/// 只有一个苹果图标 + 白底
- (ASAuthorizationAppleIDButton *)loginBtn4{
    if (!_loginBtn4) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeContinue style:ASAuthorizationAppleIDButtonStyleWhite];
        appleIDBtn.frame = CGRectMake(30, 250, 40, 40);
            appleIDBtn.cornerRadius = 20.f;
        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn4 =appleIDBtn;
    }
    return _loginBtn4;
}

/// 只有一个苹果图标 + 黑底
- (ASAuthorizationAppleIDButton *)loginBtn5{
    if (!_loginBtn5) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeContinue style:ASAuthorizationAppleIDButtonStyleBlack];
        appleIDBtn.frame = CGRectMake(80, 250, 40, 40);
            appleIDBtn.cornerRadius = 20.f;
        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn5 =appleIDBtn;
    }
    return _loginBtn5;
}


/// 信息展示
- (UILabel *)showMsgLabel{
    if (!_showMsgLabel) {
        // 用于展示Sign In With Apple 登录过程的信息
        UILabel *appleIDInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.view.frame) - 20,1400)];
        appleIDInfoLabel.font = [UIFont systemFontOfSize:22.0];
        appleIDInfoLabel.numberOfLines = 0;
        appleIDInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        appleIDInfoLabel.text = @"显示Sign In With Apple 登录信息\n";
        _showMsgLabel = appleIDInfoLabel;
    }
    return _showMsgLabel;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 300, CGRectGetWidth(self.view.frame), 400)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 1400);
        _scrollView.scrollEnabled = true;
        
        [_scrollView addSubview:self.showMsgLabel];
    }
    return _scrollView;
}


#pragma mark delegate
//@optional 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization{
    NSLog(@"授权完成:::%@", authorization.credential);
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", controller);
    NSLog(@"%@", authorization);
    
    // 测试配置UI显示
    NSMutableString *mStr = [NSMutableString string];
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; // access token
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        NSLog(@"state: %@", state);
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
        [mStr appendString:@"state:"];
        [mStr appendString:[NSString stringWithFormat:@"%@",state]];
        [mStr appendString:@"\n userID:"];
        [mStr appendString:userID];
        [mStr appendString:@"\n fullName.familyName:"];
        [mStr appendString:fullName.familyName];
        [mStr appendString:@"\n fullName.givenName:"];
        [mStr appendString:fullName.givenName];
        [mStr appendString:@"\n email:"];
        [mStr appendString:email];
        [mStr appendString:@"\n authorizationCode:"];
        [mStr appendString:authorizationCode];
        [mStr appendString:@"\n identityToken:"];
        [mStr appendString:identityToken];
        [mStr appendString:@"\n realUserStatus:"];
        [mStr appendString:[NSString stringWithFormat:@"%@",@(realUserStatus)]];
        _showMsgLabel.text = mStr;
        
        // TODO 网络返回 传递identityToken。
        
    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // Sign in using an existing iCloud Keychain credential.
        // 用户登录使用现有的密码凭证
//        ASPasswordCredential *passwordCredential = authorization.credential;
//        // 密码凭证对象的用户标识 用户的唯一标识
//        NSString *user = passwordCredential.user;
//        // 密码凭证对象的密码
//        NSString *password = passwordCredential.password;
//
//        [mStr appendString:user];
//        [mStr appendString:@"\n"];
//        [mStr appendString:password];
//        [mStr appendString:@"\n"];
//        NSLog(@"mStr:::%@", mStr);
//        _showMsgLabel.text = mStr;
        // 使用现有密码凭证，暂不考虑，因为本地存储后台token。如需用到，参数与上面相同。
    }else{
        NSLog(@"授权信息均不符");
        mStr = [@"授权信息均不符" copy];
        _showMsgLabel.text = mStr;
    }
}

// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error{
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
    
    NSMutableString *mStr = [_showMsgLabel.text mutableCopy];
    [mStr appendString:@"\n"];
    [mStr appendString:errorMsg];
    [mStr appendString:@"\n"];
    _showMsgLabel.text = mStr;
}


// 告诉代理应该在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller{
    // 返回window
    return self.view.window;
}






@end
