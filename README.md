#Debug调试模块
##前言
* [MDebugFramework](https://github.com/was0107/MDebugFramework)，为实现离线调试当前APP沙盒中的内容、环境的切换而生；

##简介
* 1、支持动态添加Debug入口，通过配置debug.plist实现;
* 2、内嵌Host环境切换功能，提供online\prod\stage三种切换，仅下次启动生效;具体环境下的业务逻辑，本库不涉及，由业务方进行实现；
* 3、支持沙盒查看，文件夹、文件（plist\txt\mp3\png\jpg）
* 4、在使用过程中，一定要注意Debug.bundle中的文件，特别是debug.plist文件中的内容，不同APP配置可能不一样。
* 5、Host默认环境为stage环境;

##使用说明
`MDebug`提供单例方法，在初次调用时，即会将当前的环境情况输出到控制台，方便调试
```
/**
 *  设置Debug呼出样式
 *
 *  @return
 */
- (void)invocationEvent:(MDebugInvocationEvent)invocationEvent;

/**
 *  返回当前的环境类型，具体的逻辑判断，由业务方进行逻辑处理
 *
 *  @return 仅在debug模式下有用，在release环境下，返回为nil;
 */
- (MDebug_ENV_TYPE) currentEnv;

/**
 *  当前环境值
 *
 *  @return 当前环境的字符串，用于输出
 */
- (NSString *) currentEnvString;
```
`MDebug`的调用方式
* 1、全局模式，在主窗体展示之后，进行设置
```
[MDebug sharedInstance].parentViewController = self;
[[MDebug sharedInstance] invocationEvent:MDebugInvocationEventBubble];
```
* 2、内嵌模式，在某一个页面单独设置
```
[MDebug sharedInstance].parentViewController = self;
[self.view addSubview:[[MDebug sharedInstance] debugView]];
```
