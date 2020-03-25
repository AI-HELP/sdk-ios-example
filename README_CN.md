[英文版接入文档](https://github.com/AI-HELP/iOS-SDK-stable/blob/master/README.md)

## IOS SDK 接入说明
1. SDK支持iOS8及以上iOS版本。
2. 甲方有义务按照乙方接入文档说明的正常接入方式和调用方式使用乙方服务，如甲方通过技术手段影响乙方计费，乙方有权在通知甲方的同时立即单方面终止服务，并要求甲方承担责任。
### 一、下载iOS SDK
1. 点击[这里](https://github.com/AI-HELP/AIhelp-iOS-SDK)右上角的“Clone or download”按钮下载IOS SDK，下载完成后解压文件。
### 二、导入ElvaChatServiceSDK
1. 导入文件夹 ElvaChatServiceSDK 到项目工程中
### 三、接入工程配置
1. 必须在 **Xcode Build Settings** 里面 **Other Linker Flags** 设置值 **-ObjC**。  
该项如果设置错误，运行时就会出现异常：`unrecognized selector sent to instance exception`  

2. 添加依赖库，在项目设置**target** -> 选项卡**General** ->**Linked Frameworks and Libraries**添加如下依赖库：  
`libsqlite3.tbd`
`libresolv.tbd`
`WebKit.framework`  

3. 设置SDK所需权限, 在项目工程的 **info.plist** 中增加4个权限：  
`Privacy - Photo Library Usage Description` 需要访问您的相册权限，才能将图片上传反馈给客服  
`Privacy - Camera Usage Description` 需要访问您的相机权限，才能拍摄问题图片并反馈给客服  
`Privacy - Photo Library Additions Usage Description` 需要照片添加权限，才能保存图片到相册  
`Privacy - Microphone Usage Description`需要访问您的麦克风权限，才能在表单页上传视频录像并反馈给客服
也可以一项一项的在Xcode里面添加权限，也可以直接用文本编辑器打开 **info.plist** 添加如下内容：  
```xml
<key>NSCameraUsageDescription</key>  
<string>需要访问您的相机权限，才能拍摄问题图片并反馈给客服</string>  
<key>NSPhotoLibraryAddUsageDescription</key>  
<string>需要照片添加权限，才能保存图片到相册</string>  
<key>NSPhotoLibraryUsageDescription</key>  
<string>需要访问您的相册权限，才能将图片上传反馈给客服</string>
<key>NSMicrophoneUsageDescription</key>
<string>需要访问您的麦克风权限，才能在表单页上传视频录像并反馈给客服</string>
```

###  四、SDK初始化（必须在应用启动阶段调用）
**甲方有义务按照乙方接入文档说明的正常接入方式和调用方式使用乙方服务，如甲方通过技术手段影响乙方计费，乙方有权在通知甲方的同时立即单方面终止服务，并要求甲方承担责任。**
1. 引入相关头文件 `#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>`
2. 在工程的 AppDelegate 中的`application:didFinishLaunchingWithOptions`方法中，调用 SDK 初始化方法。
```objc
[ECServiceSdk init:app_key Domain:app_domain AppId:app_id];
```                  
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**app_key**|app密钥，可以从Web管理系统获取 `APP Key` |
|**app_domain**|app域名，可以从Web管理系统获取 `Domain` |
|**app_id**|app唯一标识，可以从Web管理系统获取 `Platforms(AppID)` |

注：上面这三个参数，请使用注册时的邮箱地址作为登录名登录 [AIHelp 客服后台](https://aihelp.net/elva)。  
在Settings菜单Applications页面查看。  
初次使用，请先登录[AIHelp 官网](http://aihelp.net/index.html)自助注册。<br />

**初始化代码示例：（必须在应用启动阶段调用）** <br />
**甲方有义务按照乙方接入文档说明的正常接入方式和调用方式使用乙方服务，
如甲方通过技术手段影响乙方计费，乙方有权在通知甲方的同时立即单方面终止服务，并要求甲方承担责任。**
```objc
[ECServiceSdk init:@"YOUR_APP_KEY" Domain:@"YOUR_DOMAIN_NAME" AppId:@"YOUR_APP_ID"];
```  


## 开始使用SDK

### 1.界面说明
| 可选接口 | 接口作用 |备注|
|:------------- |:---------------|:---------------|
| [**showElva**](#showElva)      | 启动机器人客服界面| 
| [**showConversation**](#showConversation)|启动人工客服界面| 需先调用[setUserName](#setUserName) |
| [**showElvaOP**](#showElvaOP) | 启动运营界面| |
| [**showFAQs**](#showFAQs) | 展示全部FAQ菜单|需配置FAQ,需先调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**showFAQSection**](#showFAQSection)| 展示FAQ分类|需配置FAQ,需先调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**showSingleFAQ**](#showSingleFAQ) | 展示单条FAQ|需配置FAQ,需先调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**setSDKLanguage**](#setSDKLanguage) | 设置SDK语言|默认使用手机系统语言设置，设置后可以调用应用内设置语言|
| [**setSDKInterfaceOrientationMask**](#setSDKInterfaceOrientationMask) | 设置SDK显示方向|需要设备显示对应方向的权限|

| 建议接口 | 接口作用 |备注|
|:------------- |:---------------|:---------------|
| [**setName**](#setName) | 设置游戏名称|设置后在SDK导航栏会显示游戏的名称|
| [**setUserId**](#setUserId) | 设置用户ID|如果游客用户拿不到userId,请传入空字符串@"",SDK会生成唯一设备id来区分不同的用户|
| [**setUserName**](#setUserName) | 设置用户名称|如果拿不到userName，传入空字符串@""，会使用默认昵称"anonymous"|

注：您并不需要调用以上所有接口，尤其当您的游戏/应用只设置一个客服入口时，有的接口所展示的界面包含了其他接口，具体API细节见下方描述  



### <a name="showElva"></a>2.智能客服主界面启动，调用 `showElva` 方法，启动机器人界面<br />
```objc
[ECServiceSdk showElva:playerName
             PlayerUid:playerUid
              ServerId:serverId
         PlayerParseId:playerParseId
PlayershowConversationFlag:showConversationFlag];
```            
或
```objc
[ECServiceSdk showElva:playerName
             PlayerUid:playerUid
              ServerId:serverId
         PlayerParseId:playerParseId
PlayershowConversationFlag:showConversationFlag
                Config:config];
```
**代码示例:**
```objc
//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

[ECServiceSdk showElva:@"USER_NAME"
             PlayerUid:@"USER_ID"
              ServerId:@"123"
         PlayerParseId:@""
PlayershowConversationFlag:@"1"
                Config:config];

/* config 示例内容:
    {
        "elva-custom-metadata": {
            "elva-tags": [
                "vip",
                "pay1"
            ],
            "VersionCode": "1.0.0"       
        }
}
*/
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**playerName**|游戏中用户名称。如果拿不到userName，传入空字符串@""，会使用默认昵称"anonymous"|
|**playerUid**|用户在游戏里的唯一标示id。如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|
|**serverId**|用户所在的服务器编号。|
|**playerParseId**|传空字符串。|
|**showConversationFlag**|参数的值是 “0” 或 “1”，标识是否开启人工入口。为 “1” 时，将在机器人客服聊天界面右上角，提供人工客服聊天的入口。如下图。。|
|**config**|可选参数，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br>**说明**:elva-tags对应的值为array类型，此处传入自定义的标签，需要在[AIHelp 客服后台](https://aihelp.net/elva)配置同名称的标签才能生效。|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElva-CN-IOS.png?raw=true" width="414" alt="showElva">

**最佳实践：**

> 1. 在您应用的客服主入口触发这个接口的调用。在[AIHelp 客服后台](https://aihelp.net/elva)配置个性化的机器人欢迎语，以及更多机器人对话故事线，引导用户反馈并得到回答。
> 2. 打开人工客服入口，用户可以在机器人客服界面右上角进入人工客服进行聊天, 你也可以设置条件只让一部分用户看到这个入口。







### <a name="showConversation"></a>3.直接进行人工客服聊天，调用 `showConversation` 方法(必须确保设置用户名称信息 [`setUserName`](#setUserName) 已经调用)
```objc
[ECServiceSdk showConversation:playerUid ServerId:serverId];
```
或
```objc
[ECServiceSdk showConversation:playerUid ServerId:serverId Config:config];
```
**代码示例：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];  //需要先调用此方法

//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

[ECServiceSdk showConversation:@"PLAYER_ID" ServerId:@"123" Config:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**playerUid**|用户在游戏里的唯一标示id。如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|
|**serverId**|用户所在的服务器编号。|
|**config**|可选参数，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br>**说明**:elva-tags对应的值为array类型，此处传入自定义的标签，需要在[AIHelp 客服后台](https://aihelp.net/elva)配置同名称的标签才能生效。|

**最佳实践：**
> 通常你不需要调用这个接口，除非你想在应用里设置触发点，让用户有机会直接进入人工客服聊天界面。

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showConversation-CN-IOS.png?raw=true" width="414" alt="showConversation">





### <a name="showElvaOP"></a>4.运营主界面启动，调用 `showElvaOP ` 方法
当您想向用户展示应用程序/游戏的更新、新闻、文章或任何背景信息时，操作模块非常有用。
```objc
[ECServiceSdk showElvaOP:playerName 
               PlayerUid:playerUid 
                ServerId:serverId 
           PlayerParseId:playerParseId 
PlayershowConversationFlag:showConversationFlag 
                  Config:config];
```
或

```objc
[ECServiceSdk showElvaOP:playerName 
               PlayerUid:playerUid 
                ServerId:serverId 
           PlayerParseId:playerParseId 
PlayershowConversationFlag:showConversationFlag 
                  Config:config
         defaultTabIndex:defaultTabIndex];
``` 
**代码示例：**
```objc
//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

[ECServiceSdk showElvaOP:@"USER_NAME" 
               PlayerUid:@"USER_ID" 
                ServerId:@"123" 
           PlayerParseId:@"" 
PlayershowConversationFlag:@"1" 
                  Config:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**playerName**|游戏中用户名称。如果拿不到uname，传入空字符串@""，会使用默认昵称"anonymous"|
|**playerUid**|用户在游戏里的唯一标示id。如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|
|**serverId**|用户所在的服务器编号。|
|**playerParseId**|传空字符串。如:@""|
|**showConversationFlag**|参数的值是 “0” 或 “1”，标识是否开启人工入口。为 “1” 时，将在机器人客服聊天界面右上角，提供人工客服聊天的入口。如下图。|
|**config**|可选参数，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br>**说明**:elva-tags对应的值为array类型，此处传入自定义的标签，需要在[AIHelp 客服后台](https://aihelp.net/elva)配置同名称的标签才能生效。|
|**defaultTabIndex**|可选，进入运营界面时候展示的tab的编号。默认是0，也就是默认为第一个tab，若需默认展示客服界面tab，设置值为999。|


<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElvaOP-CN-IOS.png?raw=true" width="414" alt="showElvaOP">


**最佳实践：**
> 1. 在您应用的运营入口触发这个接口的调用。
在AIHelp 客服后台配置运营分页（tab)并且发布跟应用相关的运营公告内容。就通过AIHelp展示这些内容给用户。运营界面的最后一个分页总是机器人客服聊天界面。
> 2. 在tab页面，用户可以在页面右上角进入FAQ页面查看；在机器人客服页面（Help页面），用户可以在页面右上角进入人工客服，此人工客服入口可以通过参数设置条件，根据条件打开或关闭，只让一部分用户看到这个入口。







### <a name="showFAQs"></a>5.展示FAQ列表，调用 `showFAQs` 方法(必须确保设置用户名称信息 [`setUserName`](#setUserName) 和设置用户唯一id信息 [`setUserId`](#setUserId) 已经调用)
```objc
[ECServiceSdk showFAQs];
```
或
```objc
[ECServiceSdk showFAQs:config];
```
**代码示例：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];  //需要调用此方法
[ECServiceSdk setUserId:@"123ABC567DEF"];   //需要调用此方法

//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];
NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数
NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

//一、联系我们按钮显示逻辑
//    0、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮。不用处理 config。
//    1、一直显示：需要设置'showContactButtonFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"showContactButtonFlag"];
//    2、永不显示：需要设置'hideContactButtonFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"hideContactButtonFlag"];

//二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
//    0、默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）。不用处理 config。
//    1、直接进入人工页面：需要设置'directConversation'，添加如下代码即可
//        [config setObject:@"1" forKey:@"directConversation"];
//    2、进入机器人页面+人工客服入口按钮：需要设置'showConversationFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"showConversationFlag"];

[ECServiceSdk showFAQs:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**config**|可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工或机器人聊天的入口功能|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQs-CN-IOS.png?raw=true" width="414" alt="showFAQs">

**最佳实践：**
> 在您应用的FAQ主入口触发这个接口的调用。在AIHelp 客服后台页面配置并分类FAQ，如果您的FAQ较多，可以增加一个父级分类。






### <a name="showFAQSection"></a>6.展示相关部分FAQ，调用 `showFAQSection` 方法(必须确保设置用户名称信息 [`setUserName`](#setUserName) 和设置用户唯一id信息 [`setUserId`](#setUserId) 已经调用)<br />
```objc
[ECServiceSdk showFAQSection:sectionPublishId];
```
或
```objc
[ECServiceSdk showFAQSection:sectionPublishId Config:config];
```
**代码示例：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];  //需要调用此方法
[ECServiceSdk setUserId:@"123ABC567DEF"];   //需要调用此方法

//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];
NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数
NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

//一、联系我们按钮显示逻辑
//    0、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮。不用处理 config。
//    1、一直显示：需要设置'showContactButtonFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"showContactButtonFlag"];
//    2、永不显示：需要设置'hideContactButtonFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"hideContactButtonFlag"];

//二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
//    0、默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）。不用处理 config。
//    1、直接进入人工页面：需要设置'directConversation'，添加如下代码即可
//        [config setObject:@"1" forKey:@"directConversation"];
//    2、进入机器人页面+人工客服入口按钮：需要设置'showConversationFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"showConversationFlag"];

[ECServiceSdk showFAQSection:@"100" Config:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**sectionPublishId**|FAQ Section的PublishID（可以在[AIHelp 客服后台](https://aihelp.net/elva) 中，从FAQs菜单下[Section]菜单，查看PublishID）。|
|**config**|可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工或机器人聊天的入口功能|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQSection-CN-IOS.png?raw=true" width="414" alt="showFAQSection">





### <a name="showSingleFAQ"></a>7.展示单条FAQ，调用 `showSingleFAQ` 方法(必须确保设置用户名称信息 [`setUserName`](#setUserName) 和设置用户唯一id信息 [`setUserId`](#setUserId) 已经调用)
```objc
[ECServiceSdk showSingleFAQ:faqId];
```
或
```objc
[ECServiceSdk showSingleFAQ:faqId Config:config];
```
**代码示例：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];  //需要调用此方法
[ECServiceSdk setUserId:@"123ABC567DEF"];   //需要调用此方法

//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];
NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数
NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

//一、联系我们按钮显示逻辑
//    0、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮。不用处理 config。
//    1、一直显示：需要设置'showContactButtonFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"showContactButtonFlag"];
//    2、永不显示：需要设置'hideContactButtonFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"hideContactButtonFlag"];

//二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
//    0、默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）。不用处理 config。
//    1、直接进入人工页面：需要设置'directConversation'，添加如下代码即可
//        [config setObject:@"1" forKey:@"directConversation"];
//    2、进入机器人页面+人工客服入口按钮：需要设置'showConversationFlag'，添加如下代码即可
//        [config setObject:@"1" forKey:@"showConversationFlag"];

[ECServiceSdk showSingleFAQ:@"20" Config:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**faqId**|FAQ的编号。打开[AIHelp 客服后台](https://aihelp.net/elva)中，在**机器人→常见问题**页面下找到指定FAQ的FAQ编号，注意：此FAQID不能填写客服后台未存在的FAQ编号。|
|**config**|可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工或机器人聊天的入口功能|

注：如果在AIHelp 客服后台配置了FAQ的SelfServiceInterface，并且SDK配置了相关参数，将在显示FAQ的同时，右上角提供功能菜单，可以对相关的自助服务进行调用。<br />

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showSingleFAQ-CN-IOS.png?raw=true" width="414" alt="showSingleFAQ">






### <a name="setName"></a>8.设置游戏名称信息，调用 `setName` 方法
```objc
[ECServiceSdk setName:game_name];
```
**代码示例：**
```objc
[ECServiceSdk setName:@"Your Game"];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**game_name**|游戏名称，设置后将显示在SDK中相关界面导航栏。|

**最佳实践：**
> 在初始化后调用该接口设置游戏名称，将显示在AIHelp相关界面标题栏。





### <a name="setUserId"></a>9.设置用户唯一id信息，调用 `setUserId` 方法(使用自助服务必须调用，参见展示单条FAQ)
```objc
[ECServiceSdk setUserId:playerUid];
```
**代码示例：**
```objc
[ECServiceSdk setUserId:@"123ABC567DEF"];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**playerUid**|用户唯一ID,如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|

**最佳实践：**
> 通常你可以用在其他接口传入用户Id，无需调用该接口，但是若要使用[自助服务](#selfservice)，则必须调用。







### <a name="setUserName"></a>10.设置用户名称信息，调用 `setUserName` 方法()
```objc
[ECServiceSdk setUserName:playerName];
```
**代码示例：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**playerName**|用户名称。如果拿不到uname，传入空字符串@""，会使用默认昵称"anonymous"|

**最佳实践：**
> 1. 传入你的App的用户名称，这样在后台客户服务页面会展示用户的应用内名称，便于客服在服务用户时个性化称呼对方。
> 2. 通常你无需调用该接口，可以用其他接口传入用户名称，但是若要使用[自助服务](#selfservice)，则必须调用。




### <a name="setServerId"></a>11.设置服务器编号信息，调用 `setServerId` 方法(使用自助服务必须调用，参见展示单条FAQ)
```objc
[ECServiceSdk setServerId:serverId];
```
**代码示例：**
```objc
[ECServiceSdk setServerId:@"SERVER_ID"];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**serverId**|服务器ID。|

**最佳实践：**
> 通常你无需调用该接口，可以用其他接口传入服务器ID，但是若要使用[自助服务](#selfservice)，则必须调用。







### <a name="setSDKLanguage"></a>12.设置SDK语言，调用 `setSDKLanguage` 方法
```objc
[ECServiceSdk setSDKLanguage:language];
```
**代码示例：**
```objc
[ECServiceSdk setSDKLanguage:@"en"];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**language**|语言名称代码。如英语为en,简体中文为zh_CN。更多语言简称参见[AIHelp后台](https://aihelp.net/elva)，"设置"-->"语言"的Alias列。|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/Language-alias.png?raw=true" width="414" alt="语言Alias列">


**最佳实践：**
> 1. 通常SDK会使用手机的默认语言设置，如果你的应用使用跟手机设置不一样的语言，那么你需要在AIHelp SDK初始化之后调用此接口修改默认语言。
> 2. 如果你的应用允许用户更改语言，那么每次更改语言之后，也需要调用此接口重新设置SDK的语言。




### 13.设置机器人客服界面另一个欢迎语。

如果你设置了进入AI客服的不同入口，希望用户从不同的入口进入AI客服时显示不同的欢迎语，进入不同故事线，可以通过设置config参数来实现： 
```objc
NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];
```
**代码示例：**
```objc
//您需要将相同的标签添加到“AIHELP Web控制台”才能生效。
NSMutableArray * tags = [NSMutableArray array]; //定义tag容器
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
[customData setObject:tags forKey:@"elva-tags"]; //添加Tag值标签
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //添加自定义的参数

// 注：anotherWelcomeText是key，不能改变。需要改变的是usersay，保持和故事线中配置的UserSay内容一样
[customData setObject:@"usersay" forKey:@"anotherWelcomeText"]; //添加自定义欢迎语

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器
```
```objc
//如果是在智能客服主界面中    
[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
             PlayerUid:@"TEST_UID_123"
              ServerId:@"TEST_SRV_ID_123"
         PlayerParseId:@""
PlayershowConversationFlag:@"1"
                Config:config];
```
或
```objc
//如果是在智能客服运营主界面中
[ECServiceSdk showElvaOP:@"TEST_PLAYER_NAME"
               PlayerUid:@"TEST_UID_123"
                ServerId:@"TEST_SRV_ID_123"
           PlayerParseId:@""
PlayershowConversationFlag:@"1"
                  Config:config];
```
或   
```objc
//如果是在FAQ列表页面中进入机器人
[ECServiceSdk setUserName:@"PLAYER_NAME"];  //需要调用此方法
[ECServiceSdk setUserId:@"123ABC567DEF"];   //需要调用此方法
[ECServiceSdk showFAQs:config];
```
**最佳实践：**
> 引导用户从不同入口看到不同的服务




### 14.设置人工客服界面的另一个欢迎语
如果您想定制人工客服的欢迎语,您需要在调用对应接口的config参数里传入一对新的key,value key是:"private_welcome_str",value为您想要的定制的内容 
**代码示例：**
```objc
NSMutableDictionary *customData = [NSMutableDictionary dictionary];//定义自定义参数容器
// 注：private_welcome_str是key，不能改变。需要改变的是usersay
[customData setObject:@"usersay" forKey:@"private_welcome_str"]; //添加自定义人工欢迎语

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //定义config参数容器
[config setObject:customData forKey:@"elva-custom-metadata"]; //将customData存入容器

[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
             PlayerUid:@"TEST_UID_123"
              ServerId:@"TEST_SRV_ID_123"
         PlayerParseId:@""
PlayershowConversationFlag:@"1"
                Config:config];
```

**最佳实践：**
> 引导用户从不同入口看到不同的服务



### <a name="setRootViewController"></a>15.设置视图控制器以弹出'AIHelp' , use `setRootViewController`:<br />


**代码示例：**
```objc
[ECServiceSdk setRootViewController:viewController];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|__viewController__|设置视图控制器以弹出'aihlep'|

**最佳实践：**
> 1. 如果存在多个window,且直接调用showElva等接口，页面无法弹出时，调用此接口




### <a name="setSDKInterfaceOrientationMask"></a>16.客服系统横竖屏方向设置
##### 步骤一，设置方向权限
方法1:在项目的`General`->`Deployment Info`->`Device Orientation`中勾选设备所需支持的设备方向
`Portrait`、
`Upside Down`、
`Upside Down`、
`Landscape Right`

方法二:在`Appdelegate`中实现`application:supportedInterfaceOrientationsForWindow:`方法，并返回设备所需支持的设备方向
  
```objc
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}
```
**注意**：<br />
1:表单中上传图片使用了系统的相机和相册功能，必须要开启竖屏选项权限，否则在调用系统相机功能会导致应用crash<br />
2:如果游戏是横屏的，并开启了竖屏权限影响了游戏的方向，可以在`RootViewController.m`文件中添加`supportedInterfaceOrientations`方法，并返回游戏的支持方向
```objc
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
```
##### 步骤二，设置SDK方向
**代码示例：**
```objc
//示例1：设置SDK显示方向支持所有方向
[ECServiceSdk setSDKInterfaceOrientationMask:UIInterfaceOrientationMaskAll];

//示例2：设置SDK显示方向为横屏
[ECServiceSdk setSDKInterfaceOrientationMask:UIInterfaceOrientationMaskLandscape];

//示例3：设置SDK显示方向为竖屏
[ECServiceSdk setSDKInterfaceOrientationMask:UIInterfaceOrientationMaskPortrait];
```
**参数参考**
```objc
typedef NS_OPTIONS(NSUInteger, UIInterfaceOrientationMask) {
    UIInterfaceOrientationMaskPortrait,         // 设备(屏幕)直立
    UIInterfaceOrientationMaskLandscapeLeft,    // 设备(屏幕)向左横置
    UIInterfaceOrientationMaskLandscapeRight,   // 设备(屏幕)向右橫置
    UIInterfaceOrientationMaskPortraitUpsideDown,// 设备(屏幕)直立，上下顛倒
    UIInterfaceOrientationMaskLandscape,        // 设备(屏幕)横置,包含向左和向右   
    UIInterfaceOrientationMaskAll,              // 设备(屏幕)可以支持上下左右四个方向
    UIInterfaceOrientationMaskAllButUpsideDown  // 设备(屏幕)可以支持上左右三个个方向，但不支持直立上下颠倒
}

```
