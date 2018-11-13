# 重点提醒：
1. 必须在游戏启动代码中调用init接口进行AIHelp SDK的初始化。
2. iOS10需要在工程的**info.plist**添加权限:<br>
	`Privacy - Photo Library Usage Description`<br>
	`Privacy - Camera Usage Description`<br>
	iOS11需要在工程的**info.plist**添加权限:<br>
	`Privacy - Photo Library Additions Usage Description`<br>
3. 接口简介：

| 接口名 | 接口作用 |备注|
|:------------- |:---------------|:---------------|
| [**init**](#init)      | 初始化 | 
| [**showElva**](#showElva)      | 启动机器人客服界面| 
| [**showElvaOP**](#showElvaOP) | 启动运营界面| 需配置运营模块|
| [**showFAQs**](#showFAQs) | 展示全部FAQ菜单|需配置FAQ,需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**showFAQSection**](#showFAQSection)| 展示FAQ分类|需配置FAQ,需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
| [**showSingleFAQ**](#showSingleFAQ) | 展示单条FAQ|需配置FAQ,需调用[setUserName](#setUserName) 和[setUserId](#setUserId)|
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

注：后面这三个参数，请使用注册时的邮箱地址作为登录名登录 [AIHelp 后台](https://aihelp.net/elva)。在Settings菜单Applications页面查看。初次使用，请先登录[智能客服官网](http://aihelp.net/index.html)自助注册。<br />

**代码示例**

```
// 一定要在应用初始化时进行初始化init操作，否则无法进入AIHelp智能客服系统。
[ECServiceSdk init:@"YOUR_API_KEY"
				Domain:@"YOUR_DOMAIN_NAME"
				AppId:@"YOUR_APP_ID"];
```

## 2、调用接口完成功能需求
### <a name="showElva"></a>智能客服主界面启动，调用 `showElva` 方法，启动机器人界面<br />

	[ECServiceSdk showElva:playerName
    				PlayerUid:playerUid
    				ServerId:serverId
    				PlayerParseId:playerParseId
    				PlayershowConversationFlag:showConversationFlag];
			
或

	[ECServiceSdk showElva:playerName
					PlayerUid:playerUid
					ServerId:serverId
					PlayerParseId:playerParseId
					PlayershowConversationFlag:showConversationFlag
					Config:config];

**代码示例:**

	// Presenting AI Help Converation with your customers
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"AIHelp-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"AIHelp-custom-metadata"];
	[ECServiceSdk showElva:@"USER_NAME"
    				PlayerUid:@"USER_ID"
    				ServerId:@"123"
    				PlayerParseId:@""
    				PlayershowConversationFlag:@"1"
    				Config:config];
    				
	/*config 示例内容:
			{
				AIHelp-custom-metadata ＝｛
					AIHelp-tags ＝'军队, 充值',
					VersionCode ＝ '3'
				｝
			}
	*/
	
**参数说明:**

- __playerName__: 游戏中玩家名称。<br />
- __playerUid__:玩家在游戏里的唯一标示id。<br />
- __serverId__:玩家所在的服务器编号。<br />
- __playerParseId__:传空字符串。<br />
- __showConversationFlag(0或1)__:是否为vip, 0:标示非VIP；1:表示：VIP。此处为1时，将在机器人的聊天界面右上角，提供人工聊天的入口功能。<br />
- __config__: 可选，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br />

![showElva](https://github.com/CS30-NET/Pictures/blob/master/showElva-CN-IOS.jpg "showElva")

**最佳实践：**

> 1. 在您应用的客服主入口触发这个接口的调用。在AIHelp 配置个性化的机器人欢迎语，以及更多机器人对话故事线，引导用户反馈并得到回答。
> 2. 打开人工客服入口，用户可以在机器人客服界面右上角进入人工客服进行聊天, 你也可以设置条件只让一部分用户看到这个入口。

### <a name="showElvaOP"></a>运营主界面启动，调用 `showElvaOP ` 方法

	[ECServiceSdk showElvaOP:playerName 
					PlayerUid:playerUid 
					ServerId:serverId 
					PlayerParseId:playerParseId 
					PlayershowConversationFlag:showConversationFlag 
					Config:config];

或

	[ECServiceSdk showElvaOP:playerName 
					PlayerUid:playerUid 
					ServerId:serverId 
					PlayerParseId:playerParseId 
					PlayershowConversationFlag:showConversationFlag 
					Config:config
					defaultTabIndex:defaultTabIndex];
    
**代码示例：**

	// Presenting Operation Info to your customers
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"AIHelp-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"AIHelp-custom-metadata"];
	[ECServiceSdk showElvaOP:@"USER_NAME" 
					PlayerUid:@"USER_ID" 
					ServerId:@"123" 
					PlayerParseId:@"" 
					PlayershowConversationFlag:@"1" 
					Config:config];

**参数说明:**<br />

- __playerName__: 游戏中玩家名称。<br />
- __playerUid__:玩家在游戏里的唯一标示id。<br />
- __serverId__:玩家所在的服务器编号。<br />
- __playerParseId__:传空字符串。<br />
- __showConversationFlag(0或1)__:是否为vip, 0:标示非VIP；1:表示：VIP。此处为1时，将在机器人的聊天界面右上角，提供人工聊天的入口功能。<br />
- __config__: 可选，自定义Dictionary信息。可以在此处设置特定的Tag信息。<br />
- __defaultTabIndex__:可选，进入运营界面时候展示的tab的编号。默认是0，也就是默认为第一个tab，若需默认展示客服界面tab，设置值为999。<br />

![showElva](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElvaOP_Android.png "showElvaOP")

**最佳实践：**
> 1. 在您应用的运营入口触发这个接口的调用。
在AIHelp 后台配置运营分页（tab)并且发布跟应用相关的运营公告内容。就通过AIHelp展示这些内容给用户。运营界面的最后一个分页总是机器人客服聊天界面。
> 2. 在tab页面，用户可以在页面右上角进入FAQ页面查看；在机器人客服页面（Help页面），用户可以在页面右上角进入人工客服，此人工客服入口可以通过参数设置条件，根据条件打开或关闭，只让一部分用户看到这个入口。

### <a name="showSingleFAQ"></a>展示单条FAQ，调用 `showSingleFAQ` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 和设置玩家唯一id信息 [`setUserId`](#setUserId) 已经调用)

	[ECServiceSdk showSingleFAQ:faqId];

或

	[ECServiceSdk showSingleFAQ:faqId Config:config];

**代码示例：**

	// Presenting FAQs to your customers
	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	[ECServiceSdk setUserId:@"123ABC567DEF"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"AIHelp-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"AIHelp-custom-metadata"];
	[ECServiceSdk showSingleFAQ:@"20" Config:config];

**参数说明：**

- __faqId__: FAQ的编号。打开[AIHelp 后台](https://aihelp.net/elva)中，在**机器人→常见问题**页面下找到指定FAQ的FAQ编号，注意：此FAQID不能填写客服后台未存在的FAQ编号。<br />
- __config__: 可选，自定义Dictionary信息。参照智能客服主界面启动。<br />
注：如果在AIHelp 后台配置了FAQ的SelfServiceInterface，并且SDK配置了相关参数，将在显示FAQ的同时，右上角提供功能菜单，可以对相关的自助服务进行调用。<br />

![showSingleFAQ](https://github.com/CS30-NET/Pictures/blob/master/showSingleFAQ-CN-IOS.png "showSingleFAQ")


### <a name="showFAQSection"></a>展示相关部分FAQ，调用 `showFAQSection` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 和设置玩家唯一id信息 [`setUserId`](#setUserId) 已经调用)<br />

	[ECServiceSdk showFAQSection:sectionPublishId];

或

	[ECServiceSdk showFAQSection:sectionPublishId Config:config];
	
**代码示例：**
	
	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	[ECServiceSdk setUserId:@"123ABC567DEF"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"AIHelp-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"AIHelp-custom-metadata"];
    [config setObject:@"1" forKey:@"showContactButtonFlag"];   // 显示可以从FAQ列表右上角进入机器人客服
    [config setObject:@"1" forKey:@"showConversationFlag"];    // 显示可以从FAQ进入人工客服,需要同时设置showContactButtonFlag
	[ECServiceSdk showFAQSection:@"100" Config:config];

**参数说明：**

- __sectionPublishId__: FAQ Section的PublishID（可以在[AIHelp 后台](https://aihelp.net/elva) 中，从FAQs菜单下[Section]菜单，查看PublishID）。<br />
- __config__: 可选，自定义Dictionary信息。参照 智能客服主界面启动。<br />

![showFAQSection](https://github.com/CS30-NET/Pictures/blob/master/showFAQSection-CN-IOS.jpg "showFAQSection")

### <a name="showFAQs"></a>展示FAQ列表，调用 `showFAQs` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 和设置玩家唯一id信息 [`setUserId`](#setUserId) 已经调用)

	[ECServiceSdk showFAQs];

或

	[ECServiceSdk showFAQs:config];
	
**代码示例：**

	// Presenting FAQs to your customers
	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	[ECServiceSdk setUserId:@"123ABC567DEF"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"AIHelp-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"AIHelp-custom-metadata"];
	[ECServiceSdk showFAQs:config];

**参数说明：**

- __config__: 可选，自定义Dictionary信息。可以在此处设置特定的Tag信息和是否提供人工聊天的入口功能<br />

![showFAQs](https://github.com/CS30-NET/Pictures/blob/master/showFAQs-CN-IOS.jpg "showFAQs")

**最佳实践：**
> 在您应用的FAQ主入口触发这个接口的调用。在AIHelp 后台页面配置并分类FAQ，如果您的FAQ较多，可以增加一个父级分类。

### <a name="setName"></a>设置游戏名称信息，调用 `setName` 方法

	[ECServiceSdk setName:game_name];

**代码示例：**

	[ECServiceSdk setName:@"Your Game"];
	
**参数说明：**

- __game_name__: 游戏名称，设置后将显示在SDK中相关界面导航栏。

![setName](https://github.com/CS30-NET/Pictures/blob/master/setName-CN-IOS.jpg "setName")

**最佳实践：**
> 在初始化后调用该接口设置游戏名称，将显示在AIHelp相关界面标题栏。

### <a name="setUserId"></a>设置用户唯一id信息，调用 `setUserId` 方法(使用自助服务必须调用，参见展示单条FAQ)

	[ECServiceSdk setUserId:playerUid];

**代码示例：**

	[ECServiceSdk setUserId:@"123ABC567DEF"];

**参数说明：**

- __playerUid__: 玩家唯一ID。

**最佳实践：**
> 通常你可以用在其他接口传入用户Id，无需调用该接口，但是若要使用[自助服务](#selfservice)，则必须调用。

### <a name="setServerId"></a>设置服务器编号信息，调用 `setServerId` 方法(使用自助服务必须调用，参见展示单条FAQ)

	[ECServiceSdk setServerId:serverId];

**代码示例：**

	[ECServiceSdk setServerId:@"SERVER_ID"];
	
**参数说明：**

- __serverId__: 服务器ID。

**最佳实践：**
> 通常你无需调用该接口，可以用其他接口传入服务器ID，但是若要使用[自助服务](#selfservice)，则必须调用。

### <a name="setUserName"></a>设置玩家名称信息，调用 `setUserName` 方法()

	[ECServiceSdk setUserName:playerName];

**代码示例：**

	[ECServiceSdk setUserName:@"PLAYER_NAME"];

**参数说明：**

- __playerName__: 玩家名称。

**最佳实践：**
> 1. 传入你的App的用户名称，这样在后台客户服务页面会展示用户的应用内名称，便于客服在服务用户时个性化称呼对方。
> 2. 通常你无需调用该接口，可以用其他接口传入用户名称，但是若要使用[自助服务](#selfservice)，则必须调用。

### <a name="showConversation"></a>直接进行人工客服聊天，调用 `showConversation` 方法(必须确保设置玩家名称信息 [`setUserName`](#setUserName) 已经调用)

	[ECServiceSdk showConversation:playerUid ServerId:serverId];

或

	[ECServiceSdk showConversation:playerUid 
					ServerId:serverId 
					Config:config];

**代码示例：**

	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"AIHelp-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"AIHelp-custom-metadata"];
	[ECServiceSdk showConversation:@"PLAYER_ID" 
					ServerId:@"123" 
					Config:config];

**参数说明：**

- __playerUid__: 玩家在游戏里的唯一标示id。<br />
- __serverId__:玩家所在的服务器编号。<br />
- __config__: 可选，自定义Dictionary信息。参照智能客服主界面启动。<br />

![showConversation](https://github.com/CS30-NET/Pictures/blob/master/showConversation-CN-IOS.png "showConversation")

**最佳实践：**
> 通常你不需要调用这个接口，除非你想在应用里设置触发点，让用户有机会直接进入人工客服聊天界面。

#### <a name="setSDKLanguage"></a>设置SDK语言，调用 `setSDKLanguage` 方法

	[ECServiceSdk setSDKLanguage:language];
	
**代码示例：**

	[ECServiceSdk setSDKLanguage:@"en"];

**参数说明：**

- __language__: 语言名称。如英语为en,简体中文为zh_CN。更多语言简称参见[AIHelp后台](https://aihelp.net/elva)，"设置"-->"语言"的Alias列。

![language](https://github.com/AI-HELP/Docs-Screenshots/blob/master/Language-alias.png "语言Alias列")

**最佳实践：**
> 1. 通常SDK会使用手机的默认语言设置，如果你的应用使用跟手机设置不一样的语言，那么你需要在AIHelp SDK初始化之后调用此接口修改默认语言。
> 2. 如果你的应用允许用户更改语言，那么每次更改语言之后，也需要调用此接口重新设置SDK的语言。

#### <a name="setChangeDirection"></a>设置SDK竖屏显示，调用 `setChangeDirection` 方法

	[ECServiceSdk setChangeDirection];

* 说明:

>调用这个接口后，无论游戏的展示方向是横屏还是竖屏，SDK都是以竖屏展示，此时，SDK的显示效果最佳。如果不调用这个接口SDK会以游戏的方向为准。

#### 设置另一个欢迎语。

如果你设置了进入AI客服的不同入口，希望用户从不同的入口进入AI客服时显示不同的欢迎语，进入不同故事线，可以通过设置config参数来实现： 


	NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
	[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];
	
**代码示例：**

	NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
	
	//调用不同故事线功能，使用指定的提示语句，调出相应的机器人欢迎语
	//注：anotherWelcomeText是key，不能改变。
	//需要改变的是usersay，保持和故事线中配置的User Say内容一样
	[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	[config setObject:welcomeText forKey:@"AIHelp-custom-metadata"];
	
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
> 引导玩家从不同入口看到不同的服务

[链接]:http://blog.csdn.net/u012681458/article/details/51865435
