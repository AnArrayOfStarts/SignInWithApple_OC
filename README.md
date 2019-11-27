# SignInWithApple_OC
signInApple

1、运行demo，请在xcode中登录自己的账号哟（这是ios_OC_demo）

2、需要OC的，可以尝试直接使用 LXLSecondViewController 里的内容。

3、需要RN的，请在配置过xcode 后，使用。原生文件在 SignInWithApple_OC/iosModule/NativeSignAppleModule/ 路径下。

4、RN的调用方法如下：

    1)、是否是ios13以上版本：NativeModules.NativeSignAppleModule.isIOSThirteen((getData) =>{});
    
    2)、点击调用苹果登录 NativeModules.NativeSignAppleModule.signApple((getData) =>{});
    
    
5、说明：本demo 没有考虑手动退出苹果账号，并通知RN的情况。如有需要的话请留言，我去完善下。
