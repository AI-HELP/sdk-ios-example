[英文版接入文档](https://github.com/AI-HELP/iOS-SDK-stable/blob/master/README.md)

## IOS SDK 接入说明
1. 在您阅读此文档时，我们假定您已经具备了基础的 iOS 应用开发经验，并能够理解相关基础概念，SDK支持iOS8及以上iOS版本。
2. 甲方有义务按照乙方接入文档说明的正常接入方式和调用方式使用乙方服务，如甲方通过技术手段影响乙方计费，乙方有权在通知甲方的同时立即单方面终止服务，并要求甲方承担责任。
### 一、下载iOS SDK
1. 点击上一个页面右上角的“Clone or download”按钮下载IOS SDK，下载完成后解压文件。
### 二、导入ElvaChatServiceSDK
1. 导入ElvaChatServiceSDK的文件夹到项目中
### 三、接入工程配置
1. 在**Xcode Build Settings**里面**Other Linker Flags** 设置值**-ObjC**，否则会出现：`unrecognized selector sent to instance exception`
2. 添加依赖库，在项目设置**target** -> 选项卡**General** ->**Linked Frameworks and Libraries**添加如下依赖库：<br>
`libsqlite3.tbd`<br>
`WebKit.framework`<br>
3. 设置SDK所需权限, 在项目工程的**info.plist**中增加权限<br>
`Privacy - Photo Library Usage Description`<br>
`Privacy - Camera Usage Description`<br>
`Privacy - Photo Library Additions Usage Description`<br>

###  四、SDK初始化（必须在应用启动阶段调用）
**甲方有义务按照乙方接入文档说明的正常接入方式和调用方式使用乙方服务，如甲方通过技术手段影响乙方计费，乙方有权在通知甲方的同时立即单方面终止服务，并要求甲方承担责任。**
1. 引入相关头文件 `#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>`
2. 在工程的 AppDelegate 中的`application:didFinishLaunchingWithOptions`方法中，调用 SDK 初始化方法。
```objc
[ECServiceSdk init:appSecret Domain:domain AppId:appId];
```                  
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**appSecret**|app密钥，从Web管理系统获取。|
|**domain**|app域名，从Web管理系统获取。|
|**appId**|app唯一标识，从Web管理系统获取。|

注：后面这三个参数，请使用注册时的邮箱地址作为登录名登录 [AIHelp 后台](https://aihelp.net/elva)。在Settings菜单Applications页面查看。初次使用，请先登录[智能客服官网](http://aihelp.net/index.html)自助注册。<br />

**初始化代码示例：（必须在应用启动阶段调用）** <br />
**甲方有义务按照乙方接入文档说明的正常接入方式和调用方式使用乙方服务，
如甲方通过技术手段影响乙方计费，乙方有权在通知甲方的同时立即单方面终止服务，并要求甲方承担责任。**
```objc
[ECServiceSdk init:@"YOUR_APP_KEY" Domain:@"YOUR_DOMAIN_NAME" AppId:@"YOUR_APP_ID"];
```
### 五、接口简介
| 可选接口 | 接口作用 |备注|
|:------------- |:---------------|:---------------|
| [**showElva**](#showElva)      | 启动机器人客服界面| 
| [**showConversation**](#showConversation)|启动人工客服界面| 需调用[setUserName](#setUserName) |
| [**showElvaOP**](#showElvaOP) | 启动运营界面| |
| [**showFAQs**](#showFAQs) | 展示全部FAQ菜单|需配置FAQ,需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**showFAQSection**](#showFAQSection)| 展示FAQ分类|需配置FAQ,需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**showSingleFAQ**](#showSingleFAQ) | 展示单条FAQ|需配置FAQ,需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**setSDKLanguage**](#setSDKLanguage) | 设置SDK语言|

| 建议接口 | 接口作用 |备注|
|:------------- |:---------------|:---------------|
| [**setName**](#setName) | 设置游戏名称|设置后在SDK导航栏会显示游戏的名称|
| [**setUserId**](#setUserId) | 设置玩家(用户)ID|如果游客玩家拿不到userId,请传入空字符串@"",SDK会生成唯一设备id来区分不同的用户|
| [**setUserName**](#setUserName) | 设置玩家(用户)名称|如果拿不到uname，传入空字符串@""，会使用默认昵称"anonymous"|

注：您并不需要调用以上所有接口，尤其当您的游戏/应用只设置一个客服入口时，有的接口所展示的界面包含了其他接口，详情见下





## 开始使用SDK

### <a name="showElva"></a>智能客服主界面启动，调用 `showElva` 方法，启动机器人界面<br />
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
|**playerName**|游戏中玩家名称。如果拿不到uname，传入空字符串@""，会使用默认昵称"anonymous"|
|**playerUid**|玩家在游戏里的唯一标示id。如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|
|**serverId**|玩家所在的服务器编号。|
|**playerParseId**|传空字符串。|
|**showConversationFlag**|参数的值是 “0” 或 “1”，标识是否开启人工入口。为 “1” 时，将在机器人客服聊天界面右上角，提供人工客服聊天的入口。如下图。。|
|**config**|可选参数，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br>**说明**:elva-tags对应的值为array类型，此处传入自定义的标签，需要在[AIHelp 后台](https://aihelp.net/elva)配置同名称的标签才能生效。|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElva-CN-IOS.png?raw=true" width="414" alt="showElva">

**最佳实践：**

> 1. 在您应用的客服主入口触发这个接口的调用。在[AIHelp 客服后台](https://aihelp.net/elva)配置个性化的机器人欢迎语，以及更多机器人对话故事线，引导用户反馈并得到回答。
> 2. 打开人工客服入口，用户可以在机器人客服界面右上角进入人工客服进行聊天, 你也可以设置条件只让一部分用户看到这个入口。







### <a name="showConversation"></a>直接进行人工客服聊天，调用 `showConversation` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 已经调用)
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
|**playerUid**|玩家在游戏里的唯一标示id。如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|
|**serverId**|玩家所在的服务器编号。|
|**config**|可选参数，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br>**说明**:elva-tags对应的值为array类型，此处传入自定义的标签，需要在[AIHelp 后台](https://aihelp.net/elva)配置同名称的标签才能生效。|

**最佳实践：**
> 通常你不需要调用这个接口，除非你想在应用里设置触发点，让用户有机会直接进入人工客服聊天界面。

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showConversation-CN-IOS.png?raw=true" width="414" alt="showConversation">





### <a name="showElvaOP"></a>运营主界面启动，调用 `showElvaOP ` 方法
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
|**playerName**|游戏中玩家名称。如果拿不到uname，传入空字符串@""，会使用默认昵称"anonymous"|
|**playerUid**|玩家在游戏里的唯一标示id。如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|
|**serverId**|玩家所在的服务器编号。|
|**playerParseId**|传空字符串。如:@""|
|**showConversationFlag**|参数的值是 “0” 或 “1”，标识是否开启人工入口。为 “1” 时，将在机器人客服聊天界面右上角，提供人工客服聊天的入口。如下图。|
|**config**|可选参数，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br>**说明**:elva-tags对应的值为array类型，此处传入自定义的标签，需要在[AIHelp 后台](https://aihelp.net/elva)配置同名称的标签才能生效。|
|**defaultTabIndex**|可选，进入运营界面时候展示的tab的编号。默认是0，也就是默认为第一个tab，若需默认展示客服界面tab，设置值为999。|


<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElvaOP-CN-IOS.png?raw=true" width="414" alt="showElvaOP">


**最佳实践：**
> 1. 在您应用的运营入口触发这个接口的调用。
在AIHelp 后台配置运营分页（tab)并且发布跟应用相关的运营公告内容。就通过AIHelp展示这些内容给用户。运营界面的最后一个分页总是机器人客服聊天界面。
> 2. 在tab页面，用户可以在页面右上角进入FAQ页面查看；在机器人客服页面（Help页面），用户可以在页面右上角进入人工客服，此人工客服入口可以通过参数设置条件，根据条件打开或关闭，只让一部分用户看到这个入口。







### <a name="showFAQs"></a>展示FAQ列表，调用 `showFAQs` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 和设置玩家唯一id信息 [`setUserId`](#setUserId) 已经调用)
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
//0、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮
//1、一直显示：设置'showContactButtonFlag'
//2、永不显示：设置'hideContactButtonFlag'
int showType = 0;
switch (showType) {
    case 0:break;
    case 1:[config setObject:@"1" forKey:@"showContactButtonFlag"];break;
    case 2:[config setObject:@"1" forKey:@"hideContactButtonFlag"];break;
}
//二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
//0、默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）
//1、直接进入人工页面：设置'directConversation'
//2、进入机器人页面+人工客服入口按钮：设置'showConversationFlag'
int logicType = 0;
switch (logicType) {
    case 0:break;
    case 1:[config setObject:@"1" forKey:@"directConversation"];break;
    case 2:[config setObject:@"1" forKey:@"showConversationFlag"];break;
}

[ECServiceSdk showFAQs:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**config**|可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工或机器人聊天的入口功能|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQs-CN-IOS.png?raw=true" width="414" alt="showFAQs">

**最佳实践：**
> 在您应用的FAQ主入口触发这个接口的调用。在AIHelp 后台页面配置并分类FAQ，如果您的FAQ较多，可以增加一个父级分类。






### <a name="showFAQSection"></a>展示相关部分FAQ，调用 `showFAQSection` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 和设置玩家唯一id信息 [`setUserId`](#setUserId) 已经调用)<br />
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
//0、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮
//1、一直显示：设置'showContactButtonFlag'
//2、永不显示：设置'hideContactButtonFlag'
int showType = 0;
switch (showType) {
    case 0:break;
    case 1:[config setObject:@"1" forKey:@"showContactButtonFlag"];break;
    case 2:[config setObject:@"1" forKey:@"hideContactButtonFlag"];break;
}
//二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
//0、默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）
//1、直接进入人工页面：设置'directConversation'
//2、进入机器人页面+人工客服入口按钮：设置'showConversationFlag'
int logicType = 0;
switch (logicType) {
    case 0:break;
    case 1:[config setObject:@"1" forKey:@"directConversation"];break;
    case 2:[config setObject:@"1" forKey:@"showConversationFlag"];break;
}

[ECServiceSdk showFAQSection:@"100" Config:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**sectionPublishId**|FAQ Section的PublishID（可以在[AIHelp 后台](https://aihelp.net/elva) 中，从FAQs菜单下[Section]菜单，查看PublishID）。|
|**config**|可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工或机器人聊天的入口功能|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQSection-CN-IOS.png?raw=true" width="414" alt="showFAQSection">





### <a name="showSingleFAQ"></a>展示单条FAQ，调用 `showSingleFAQ` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 和设置玩家唯一id信息 [`setUserId`](#setUserId) 已经调用)
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
//0、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮
//1、一直显示：设置'showContactButtonFlag'
//2、永不显示：设置'hideContactButtonFlag'
int showType = 0;
switch (showType) {
    case 0:break;
    case 1:[config setObject:@"1" forKey:@"showContactButtonFlag"];break;
    case 2:[config setObject:@"1" forKey:@"hideContactButtonFlag"];break;
}
//二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
//0、默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）
//1、直接进入人工页面：设置'directConversation'
//2、进入机器人页面+人工客服入口按钮：设置'showConversationFlag'
int logicType = 0;
switch (logicType) {
    case 0:break;
    case 1:[config setObject:@"1" forKey:@"directConversation"];break;
    case 2:[config setObject:@"1" forKey:@"showConversationFlag"];break;
}

[ECServiceSdk showSingleFAQ:@"20" Config:config];
```
**参数说明:**

|参数|说明|
|:------------- |:---------------|
|**faqId**|FAQ的编号。打开[AIHelp 后台](https://aihelp.net/elva)中，在**机器人→常见问题**页面下找到指定FAQ的FAQ编号，注意：此FAQID不能填写客服后台未存在的FAQ编号。|
|**config**|可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工或机器人聊天的入口功能|

注：如果在AIHelp 后台配置了FAQ的SelfServiceInterface，并且SDK配置了相关参数，将在显示FAQ的同时，右上角提供功能菜单，可以对相关的自助服务进行调用。<br />

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showSingleFAQ-CN-IOS.png?raw=true" width="414" alt="showSingleFAQ">






### <a name="setName"></a>设置游戏名称信息，调用 `setName` 方法
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





### <a name="setUserId"></a>设置用户唯一id信息，调用 `setUserId` 方法(使用自助服务必须调用，参见展示单条FAQ)
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
|**playerUid**|玩家唯一ID,如果拿不到uid，传入空字符串@""，系统会生成一个唯一设备id|

**最佳实践：**
> 通常你可以用在其他接口传入用户Id，无需调用该接口，但是若要使用[自助服务](#selfservice)，则必须调用。







### <a name="setUserName"></a>设置玩家名称信息，调用 `setUserName` 方法()
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
|**playerName**|玩家名称。如果拿不到uname，传入空字符串@""，会使用默认昵称"anonymous"|

**最佳实践：**
> 1. 传入你的App的用户名称，这样在后台客户服务页面会展示用户的应用内名称，便于客服在服务用户时个性化称呼对方。
> 2. 通常你无需调用该接口，可以用其他接口传入用户名称，但是若要使用[自助服务](#selfservice)，则必须调用。




### <a name="setServerId"></a>设置服务器编号信息，调用 `setServerId` 方法(使用自助服务必须调用，参见展示单条FAQ)
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







### <a name="setSDKLanguage"></a>设置SDK语言，调用 `setSDKLanguage` 方法
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







### <a name="setRootViewController"></a>13.设置视图控制器以弹出'AIHelp' , use `setRootViewController`:<br />


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








### 设置另一个欢迎语。

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
> 引导玩家从不同入口看到不同的服务

[链接]:http://blog.csdn.net/u012681458/article/details/51865435
