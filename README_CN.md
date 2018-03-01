# 重点提醒：
1. 必须在游戏启动代码中调用init接口进行AIHelp SDK的初始化。
2. iOS10需要获取权限，具体方法参考[链接](http://blog.csdn.net/u012681458/article/details/51865435)
3. 接口简介：

| 接口名 | 接口作用 |备注|
|:------------- |:---------------|:---------------|
| [**init**](#init)      | 初始化 | 
| [**showElva**](#showElva)      | 启动机器人客服界面| 
| [**showElvaOP**](#showElvaOP) | 启动运营界面| 需配置运营模块|
| [**showFAQs**](#showFAQs) | 展示全部FAQ菜单|需配置FAQ|
| [**showFAQSection**](#showFAQSection)| 展示FAQ分类|
| [**showSingleFAQ**](#showSingleFAQ) | 展示单条FAQ|需配置FAQ|
| [**showConversation**](#showConversation)|进入人工客服界面| 需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**setName**](#setName) | 设置在客服系统中显示的游戏名称|在初始化之后调用|
| [**setUserId**](#setUserId) | 设置玩家(用户)ID|
| [**setUserName**](#setUserName) | 设置玩家(用户)名称|
| [**setSDKLanguage**](#setSDKLanguage) | 设置SDK语言|

# IOS SDK 接入说明
# 一、下载iOS SDK
点击上一个页面右上角的“Clone or download”按钮下载IOS SDK，下载完成后解压文件。
# 二、导入ElvaChatServiceSDK
导入ElvaChatServiceSDK的文件到项目中     
# 三、接入工程配置 
1. 在xcode Build Settings里面Other Linker Flags 设置值-ObjC，否则会出现：`unrecognized selector sent to instance exception`
2. 如果您的Xcode工程本身没有引入webkit.framework，那么你需要手动增加webkit.framework到工程里。

# 四、接口调用说明
## <a name="init"></a>1、SDK初始化（必须在游戏应用启动阶段调用）
在游戏启动时调用初始化接口init:

    [ECServiceSdk init:appSecret
                       Domain:domain
                       appId:appId
    ];
* 其中：

>appSecret:app密钥，从Web管理系统获取。<br />
domain:app域名，从Web管理系统获取。<br />
appId:app唯一标识，从Web管理系统获取。<br />

注：后面这三个参数，请使用注册时的邮箱地址作为登录名登录 [智能客服后台](https://aihelp.net/elva)。在Settings菜单Applications页面查看。初次使用，请先登录[智能客服官网](http://aihelp.net/index.html)自助注册。<br />

## 2、调用接口完成功能需求
### <a name="showElva"></a>智能客服主界面启动，调用`showElva`方法，启动机器人界面<br />

```
// 不带config 参数
[ECServiceSdk showElva:playerName 
				PlayerUid:playerUid 
				ServerId:serverId 
				PlayerParseId:playerParseId
				PlayershowConversationFlag:playershowConversationFlag
];

// 带config参数
[ECServiceSdk showElva:playerName 
				PlayerUid:playerUid 
				ServerId:serverId 
				PlayerParseId:playerParseId
				PlayershowConversationFlag:playershowConversationFlag
				Config:customData
];
```
    
* 参数说明:<br />

>playerName: 游戏中玩家名称。<br />
playerUid:玩家在游戏里的唯一标示id。<br />
serverId:玩家所在的服务器编号。<br />
playerParseId:传空。<br />
showConversationFlag(0或1):是否为vip, 0:标示非VIP；1:表示：VIP。此处为1时，将在机器人的聊天界面右上角，提供人工聊天的入口功能。<br />
config : 可选，自定义ValueMap信息。可以在此处设置特定的Tag信息。<br />

![showElva](https://github.com/CS30-NET/Pictures/blob/master/showElva-CN-IOS.jpg "showElva")

* 参数示例:<br />

```
    NSString* NSuserName = "elvaTestName";
    NSString* NSuserId = "12349303258";
    NSString* parseId = "";
    NSString *conversationFlag = "1";
    NSString* serverIdStr = "es234-3dfs-d42f-342sfe3s3";
    
    NSMutableDictionary *customData = [NSMutableDictionary dictionary];
    
    [ECServiceSdk showElva:NSuserName 
                  PlayerUid:NSuserId 
    				 ServerId:serverIdStr 
                  PlayerParseId:parseId 
                  PlayershowConversationFlag:conversationFlag 
                  Config :customData
    ];

/* customData示例内容
      { 
        hs-custom-metadata＝｛
        hs-tags＝’军队，充值’, 
        VersionCode＝’3’
        ｝
      }
      说明：hs-tags对应的值为vector类型，此处传入自定义的Tag，需要在Web管理配置同名称的Tag才能生效。
*/
```

### <a name="showElvaOP"></a>运营主界面启动，调用`showElvaOP `方法

```
[ECServiceSdk showElvaOP:playerName 
              PlayerUid:playerUid 
              ServerId:serverId 
              PlayerParseId:playerParseId
              PlayershowConversationFlag:playershowConversationFlag
              Config:config 
              defaultTabIndex:0];
```
    
* 参数说明:<br />

>playerName: 游戏中玩家名称。<br />
playerUid:玩家在游戏里的唯一标示id。<br />
serverId:玩家所在的服务器编号。<br />
playerParseId:传空。<br />
showConversationFlag(0或1):是否为vip, 0:标示非VIP；1:表示：VIP。此处为1时，将在机器人的聊天界面右上角，提供人工聊天的入口功能。<br />
config : 可选，自定义ValueMap信息。可以在此处设置特定的Tag信息。<br />
defaultTabIndex:默认为0。<br />

### <a name="showSingleFAQ"></a>展示单条FAQ，调用`showSingleFAQ`方法

```
[ECServiceSdk showSingleFAQ:faqid];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];
[ECServiceSdk showSingleFAQ:faqid Config:customData];
```

* 参数说明：

>faqId：FAQ的PublishID,可以在[智能客服后台](https://cs30.net/elva)中，从FAQs菜单下找到指定FAQ，查看PublishID.<br />
config : 可选，自定义ValueMap信息。参照智能客服主界面启动。<br />
注：如果在智能客服后台配置了FAQ的SelfServiceInterface，并且SDK配置了相关参数，将在显示FAQ的同时，右上角提供功能菜单，可以对相关的自助服务进行调用。<br />

![showSingleFAQ](https://github.com/CS30-NET/Pictures/blob/master/showSingleFAQ-CN-IOS.png "showSingleFAQ")


### <a name="showFAQSection"></a>展示相关部分FAQ，调用`showFAQSection`方法<br />
```
[ECServiceSdk showFAQSection:sectionId];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];
[ECServiceSdk showFAQSection:sectionId Config:customData];
```

* 参数说明：

>sectionPublishId：FAQ Section的PublishID（可以在[智能客服后台](https://cs30.net/elva) 中，从FAQs菜单下[Section]菜单，查看PublishID）。<br />
config : 可选，自定义ValueMap信息。参照 智能客服主界面启动。<br />

![showFAQSection](https://github.com/CS30-NET/Pictures/blob/master/showFAQSection-CN-IOS.jpg "showFAQSection")

### <a name="showFAQs"></a>展示FAQ列表，调用`showFAQs`方法
```
 [ECServiceSdk showFAQs];
 
 NSMutableDictionary *customData = [NSMutableDictionary dictionary];
 [ECServiceSdk showFAQs:customData];
```

* 参数说明：

>config : 可选，自定义ValueMap信息。可以在此处设置特定的Tag信息和是否提供人工聊天的入口功能<br />

![showFAQs](https://github.com/CS30-NET/Pictures/blob/master/showFAQs-CN-IOS.jpg "showFAQs")

### <a name="setName"></a>设置游戏名称信息，调用`setName`方法

```
[ECServiceSdk setName:gameName];
```
* 参数说明:

> gameName：游戏名称，设置后将显示在SDK中相关界面导航栏。

* 代码示例:

> [ECServiceSdk setName:@"聊天客服"];<br />
> 见下图中红框中的文字。<br />

![setName](https://github.com/CS30-NET/Pictures/blob/master/setName-CN-IOS.jpg "setName")

### <a name="setUserId"></a>设置用户id信息，调用`setUserId`方法(使用自助服务必须调用，参见展示单条FAQ)
```
    [ECServiceSdk setUserId:userId];
```

* 参数说明:

> userId：玩家唯一ID。

### <a name="setServerId"></a>设置服务器编号信息，调用`setServerId`方法(使用自助服务必须调用，参见展示单条FAQ)

```
    [ECServiceSdk setServerId:serverIdStr];
```
* 参数说明:

> serverIdStr:服务器ID。

### <a name="setUserName"></a>设置玩家名称信息，调用`setUserName`方法()

```
    [ECServiceSdk setUserName:userName];
```

* 参数说明:

> userName:玩家名称。

### <a name="showConversation"></a>直接进行人工客服聊天，调用`showConversation`方法(必须确保设置玩家名称信息setUserName 已经调用)

```
// 不带可选参数
[ECServiceSdk showConversation:userId ServerId:serverIdStr];
        
// 带可选参数
NSMutableDictionary *customData = [NSMutableDictionary dictionary];
[ECServiceSdk showConversation:userId 
					ServerId:serverIdStr 
					Config:customData];
```

* 参数说明:

>playerUid:玩家在游戏里的唯一标示id。<br />
serverId:玩家所在的服务器编号。<br />
config : 可选，自定义ValueMap信息。参照 智能客服主界面启动。<br />

![showConversation](https://github.com/CS30-NET/Pictures/blob/master/showConversation-CN-IOS.png "showConversation")

#### <a name="setSDKLanguage"></a>设置SDK语言，调用`setSDKLanguage`方法

	[ECServiceSdk setSDKLanguage:language];

* 参数说明:

>language:语言名称。如英语为en,简体中文为zh_CN。更多语言简称参见AIHelp后台，"设置"-->"语言"的Alias列。
>> 1. 通常SDK会使用手机的默认语言设置，如果你的应用使用跟手机设置不一样的语言，那么你需要在AIHelp SDK初始化之后调用此接口修改默认语言。
>> 2. 如果你的应用允许用户更改语言，那么每次更改语言之后，也需要调用此接口重新设置SDK的语言。

![language](https://github.com/AI-HELP/Docs-Screenshots/blob/master/Language-alias.png "语言Alias列")

#### <a name="setChangeDirection"></a>设置SDK竖屏显示，调用`setChangeDirection`方法

	[ECServiceSdk setChangeDirection];

* 说明:

>调用这个接口后，无论游戏的展示方向是横屏还是竖屏，SDK都是以竖屏展示，此时，SDK的显示效果最佳。如果不调用这个接口SDK会以游戏的方向为准。

#### 设置另一个欢迎语。

如果你设置了进入AI客服的不同入口，希望用户从不同的入口进入AI客服时显示不同的欢迎语，进入不同故事线，可以通过设置config参数来实现： 
	
**代码示例：**

	NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
	
	//调用不同故事线功能，使用指定的提示语句，调出相应的机器人欢迎语
	//注：anotherWelcomeText是key，不能改变。
	//需要改变的是usersay，保持和故事线中配置的User Say内容一样
	[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	[config setObject:welcomeText forKey:@"elva-custom-metadata"];
	
	//如果是在智能客服主界面中	
	[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
                  PlayerUid:@"TEST_UID_123"
                  ServerId:@"TEST_SRV_ID_123"
                  PlayerParseId:@""
                  PlayershowConversationFlag:@"1"
                  Config:config];
或

	//如果是在智能客服运营主界面中
	[ECServiceSdk showElvaOP:@"TEST_PLAYER_NAME"
                  PlayerUid:@"TEST_UID_123"
                  ServerId:@"TEST_SRV_ID_123"
                  PlayerParseId:@""
                  PlayershowConversationFlag:@"1"
                  Config:config];


**最佳实践：**
>引导玩家从不同入口看到不同的服务