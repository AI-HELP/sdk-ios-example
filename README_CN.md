# 重点提醒：
1. 必须在游戏启动代码中调用init接口进行AIHelp SDK的初始化。
2. iOS10需要获取权限，具体方法参考[链接](http://blog.csdn.net/u012681458/article/details/51865435)
3. 接口简介：

| 接口名 | 接口作用 |
|:------------- |:---------------|
| init      | 初始化 | 
| showElva      | 启动机器人客服界面| 
| showFAQs | 展示全部FAQ菜单|
| showFAQSection| 展示FAQ分类|
| showSingleFAQ | 展示单条FAQ|
|showConversation|进入人工客服界面|
| showElvaOP | 启动运营界面|

# IOS SDK 接入说明
# 一、下载iOS SDK
点击上一个页面右上角的“Clone or download”按钮下载IOS SDK，下载完成后解压文件。
# 二、导入ElvaChatService
导入ElvaChatService的文件到项目中     
# 三、接入工程配置 
1. 在xcode Build Settings里面Other Linker Flags 设置值-ObjC，否则会出现：`unrecognized selector sent to instance exception`
2. 如果您的Xcode工程本身没有引入webkit.framework，那么你需要手动增加webkit.framework到工程里。

# 四、接口调用说明
## 1、SDK初始化（必须在游戏应用启动阶段调用）
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
### 智能客服主界面启动，调用`showElva`方法，启动机器人界面<br />

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

### 运营主界面启动，调用`showElvaOP `方法

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
最后一个参数总是为0

### 展示单条FAQ，调用`showSingleFAQ`方法

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


### 展示相关部分FAQ，调用`showFAQSection`方法<br />
```
[ECServiceSdk showFAQSection:sectionId];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];
[ECServiceSdk showFAQSection:sectionId Config:customData];
```

* 参数说明：

>sectionPublishId：FAQ Section的PublishID（可以在[智能客服后台](https://cs30.net/elva) 中，从FAQs菜单下[Section]菜单，查看PublishID）。<br />
config : 可选，自定义ValueMap信息。参照 智能客服主界面启动。<br />

![showFAQSection](https://github.com/CS30-NET/Pictures/blob/master/showFAQSection-CN-IOS.jpg "showFAQSection")

### 展示FAQ列表，调用`showFAQs`方法
```
 [ECServiceSdk showFAQs];
 
 NSMutableDictionary *customData = [NSMutableDictionary dictionary];
 [ECServiceSdk showFAQs:customData];
```

* 参数说明：

>config : 可选，自定义ValueMap信息。可以在此处设置特定的Tag信息和是否提供人工聊天的入口功能<br />

![showFAQs](https://github.com/CS30-NET/Pictures/blob/master/showFAQs-CN-IOS.jpg "showFAQs")

### 设置游戏名称信息，调用`setName`方法

```
[ECServiceSdk setName:gameName];
```

* 参数说明:
>game_name：游戏名称，设置后将显示在SDK中相关界面标题栏。

### 设置用户id信息，调用`setUserId`方法(使用自助服务必须调用，参见展示单条FAQ)
```
    [ECServiceSdk setUserId:userId];
```

* 参数说明:

>playerUid：玩家唯一ID。

### 设置服务器编号信息，调用`setServerId`方法(使用自助服务必须调用，参见展示单条FAQ)

```
    [ECServiceSdk setServerId:serverIdStr];
```
* 参数说明:
>serverId:服务器ID。

### 设置玩家名称信息，调用`setUserName`方法()

```
    [ECServiceSdk setUserName:userName];
```

* 参数说明:
>playerName:玩家名称。

### 直接进行vip_chat人工客服聊天，调用`showConversation`方法(必须确保设置玩家名称信息setUserName 已经调用)

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
