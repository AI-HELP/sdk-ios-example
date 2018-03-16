[中文版接入文档](https://github.com/AI-HELP/iOS-SDK-stable/blob/master/README_CN.md)

# HIGHLIGHTS<br />
1.Remember to initialize `init`, otherwise the user can not enter the Elva intelligent customer service system.<br />
2.Please check the **Info.plist** and **TARGETS->info->Custom iOS Target Properties** in your project file for these permissions: `Privacy - Camera Usage Description` and `Privacy - Photo Library Usage Description`, if not, please add following.<br />

# AIHelp iOS SDK Integration Guide
## Ⅰ. Download iOS SDK
Click the button "Clone or download" in the top right corner to download iOS SDK and then unzip the file.
## Ⅱ. Import ElvaChatServiceSDK into project
Copy the ElvaChatServiceSDK folder to your main directory.
## Ⅲ. Project Settings
1. Add framework to Link Binary with Libraries: `webkit.framework`(if using [**showElvaOP**](#showElvaOP)).
2. Add `-ObjC` to Build Settings-Other Linker Flags.

## Ⅳ.Interface Call Instructions
You must use `init` in your App's Initialization Code, otherwise you can not use AIHelps' service properly.

	[ECServiceSdk init:appSecret
    				Domain:domain
    				appId:appId];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
| appSecret    | Your unique Developer API Key|
| domain     | Your AIHelp Domain Name. For example: foo.AIHELP.NET|
| appId     | A unique ID Assigned to your App.| 

Note: Please log into [AIHelp Web Console](https://aihelp.net/elva) with your registered email account to find the __appKey__, __domain__ and __appId__ In the _Application_ page of the _Settings_ Menu. 
If your company doesn't have an account, you need to register an account at [AIHelp Website](http://aihelp.net/index.html)

**Coding Example：**

```
// Must be called during application/game initialization, otherwise you can't use AIHelp properly.

[ECServiceSdk init:@"YOUR_API_KEY"
				Domain:@"YOUR_DOMAIN_NAME"
				AppId:@"YOUR_APP_ID"];
```

---

## Ⅴ. Start Using AIHelp
### 1. API Summary:<br />

| Method | Purpose |Prerequisites|
|:------------- |:---------------|:---------------|
| [**showElva**](#showElva)      | Launch AI Conversation Interface| 
| [**showElvaOP**](#showElvaOP) | Launch Operation Interface| Need to configure Operation Sections|
| [**showFAQs**](#showFAQs) | Show all FAQs by Sections|Need to Configure FAQs,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showFAQSection**](#showFAQSection)| Show FAQ Section|Need to Configure FAQs,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showSingleFAQ**](#showSingleFAQ) | Show Single FAQ|Need to Configure FAQ,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showConversation**](#showConversation)|Launch Manual Conversation Interface| Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**setName**](#setName) |Set Your App's Name for AIHelp SDK to Display|Use it After Initialization|
| [**setUserId**](#setUserId) | Set unique User ID|
| [**setUserName**](#setUserName) | Set User In-App Name|
| [**setServerId**](#setServerId) | Set Unique Server ID|
| [**setSDKLanguage**](#setSDKLanguage) | Set SDK Language|

**Note：It is not necessary for you to use all the APIs, especially when you only have one user interface for the customer service in your application. Some APIs already contains entry to other APIs, see below for details：**	

### <a name="showElva"></a>2. Launch the AI Conversation Interface, Use `showElva`:<br />

	[ECServiceSdk showElva:playerName
    				PlayerUid:playerUid
    				ServerId:serverId
    				PlayerParseId:playerParseId
    				PlayershowConversationFlag:showConversationFlag];
			
or

	[ECServiceSdk showElva:playerName
					PlayerUid:playerUid
					ServerId:serverId
					PlayerParseId:playerParseId
					PlayershowConversationFlag:showConversationFlag
					Config:config];
				
**Coding Example：**

	// Presenting AI Help Converation with your customers
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"elva-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"elva-custom-metadata"];
	[ECServiceSdk showElva:@"USER_NAME"
    				PlayerUid:@"USER_ID"
    				ServerId:@"123"
    				PlayerParseId:@""
    				PlayershowConversationFlag:@"1"
    				Config:config];
    				
	/*config example content:
			{
				elva-custom-metadata ＝｛
					hs-tags ＝'army, pay',
					VersionCode ＝ '3'
				｝
			}
	*/

**About Parameters：**

- __playerName__: In-App User Name
- __playerUid__: In-App Unique User ID
- __serverId__: The Server ID
- __playerParseId__: Can be empty string, can NOT be NULL.
- __showConversationFlag__: Should be "0" or "1". If set "1", the manual conversation entry will be displayed in the upper right hand side of the AI conversation interface.
- __config__: Optional parameters for custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note you also need to configure the same tag information in the Web console so that each conversation can be correctly tagged.
	
![showElva](https://github.com/AIHELP-NET/Pictures/blob/master/showElva-EN-iOS.png "showElva")
	
**Best Practice：**

> 1. Use this method to launch your APP's customer service. Configure specific welcome texts and AI story lines in the AIHelp Web Console to better the customer support experiences.
> 2. Enable Manual Conversation Entry to allow users' to chat with your human support team with the  parameter "__showConversationFlag__" setting to "__1__", you may use this method for any user or as a privilege for some users only.

### <a name="showElvaOP"></a>3. Launch The Operation Interface, use `showElvaOP`:<br />

The operation module is useful when you want to present updates, news, articles or any background information about your APP/Game to users.

	[ECServiceSdk showElvaOP:playerName 
					PlayerUid:playerUid 
					ServerId:serverId 
					PlayerParseId:playerParseId 
					PlayershowConversationFlag:showConversationFlag 
					Config:config];

or

	[ECServiceSdk showElvaOP:playerName 
					PlayerUid:playerUid 
					ServerId:serverId 
					PlayerParseId:playerParseId 
					PlayershowConversationFlag:showConversationFlag 
					Config:config
					defaultTabIndex:defaultTabIndex];

**Coding Example：**

	// Presenting Operation Info to your customers
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"elva-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"elva-custom-metadata"];
	[ECServiceSdk showElvaOP:@"USER_NAME" 
					PlayerUid:@"USER_ID" 
					ServerId:@"123" 
					PlayerParseId:@"" 
					PlayershowConversationFlag:@"1" 
					Config:config];

**About Parameters：**

- __playerName__: User Name in Game/APP
- __playerUid__: Unique User ID
- __serverId__: The Server ID
- __playerParseId__: Can be empty string, can NOT be NULL.
- __showConversationFlag__: Should be "0" or "1". If set at "1", the manual conversation entry will be shown in the top right-hand corner of the AI conversation interface.
- __config__: Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console so that each conversation can be correctly tagged.
- __defaultTabIndex__: Optional. The index of the first tab will to be shown when entering the operation interface. Default value is 0, default value of is the left-most tab, if you would like to show the AI conversation interface(the right-most) should be set to 999.
	
![showElva](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElvaOP_Android.png "showElvaOP")

**Best Practice：**
> 1. Use this API to present news, announcements, articles or any useful information to users/players. Configure and publish the information in AIHelp web console. 

### <a name="showFAQs"></a>4. Display FAQs, use `showFAQs` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />

	[ECServiceSdk showFAQs];

or

	[ECServiceSdk showFAQs:config];

**Coding Example：**

	// Presenting FAQs to your customers
	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	[ECServiceSdk setUserId:@"123ABC567DEF"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"elva-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"elva-custom-metadata"];
	[ECServiceSdk showFAQs:config];

**About Parameters：**

- __config__: Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.
	
![showElva](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQs-EN-iOS.jpg "showFAQs")

**Best Practice：**
> 1. Use this method to show FAQs about your APP/Game properly. Configure FAQs in AIHelp Web Console. Each FAQ can be categroized into a section. If the FAQs are great in number, you can also add Parent Sections to categorize sections to make things clear and organized. 

### <a name="showSingleFAQ"></a>5. Show A Specific FAQ, use `showSingleFAQ` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />

	[ECServiceSdk showSingleFAQ:faqId];

or

	[ECServiceSdk showSingleFAQ:faqId Config:config];

**Coding Example：**

	// Presenting FAQs to your customers
	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	[ECServiceSdk setUserId:@"123ABC567DEF"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"elva-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"elva-custom-metadata"];
	[ECServiceSdk showSingleFAQ:@"20" Config:config];

**About Parameters：**

- __faqId__: The PublishID of the FAQ item, you can check it at [AIHelp Web Console](https://aihelp.net/elva): Find the FAQ in the FAQ menu and copy its PublishID.
- __config__: Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.
	
![showSingleFAQ](https://github.com/AIHELP-NET/Pictures/blob/master/showSingleFAQ-EN-iOS.jpg "showSingleFAQ")

**Best Practice：**
> 1. Use this method when you want to show a specific FAQ in a proper location of your APP/Game.

### <a name="setName"></a>6. Set Your App's Name for AIHelp SDK to Display, use `setName`:<br />

	[ECServiceSdk setName:game_name];

**Coding Example：**

	[ECServiceSdk setName:@"Your Game"];

**About Parameters：**

- __game_name__: APP/Game Name

**Best Practice：**
> 1. Use this method after the SDK initialization.The App's name will be displayed in the title bar of the customer service interface.

### <a name="setUserId"></a>7. Set the Unique User ID, use `setUserId`:<br />

	[ECServiceSdk setUserId:playerUid];

**Coding Example：**

	[ECServiceSdk setUserId:@"123ABC567DEF"];

**About Parameters：**

- __playerUid__:Unique User ID

**Best Practice：**
> 1. Normally you don not need to use this method if you have passed the user ID in another method.

### <a name="setUserName"></a>8. Set User Name, use `setUserName`:<br />

	[ECServiceSdk setUserName:playerName];

**Coding Example：**

	[ECServiceSdk setUserName:@"PLAYER_NAME"];

**About Parameters：**

- __playerName:__ User/Player Name

**Best Practice：**
> 1. Use this method to set the user name, which will be shown in the web console's conversation page for the user. You can address the user with this name during the chat.
> 2. Normally you don't need to use this method if you have passed user name in other method. 

### <a name="setServerId"></a>9. Set Unique Server ID, use `setServerId`:<br />

	[ECServiceSdk setServerId:serverId];

**Coding Example：**

	[ECServiceSdk setServerId:@"SERVER_ID"];

**About Parameters：**

- __serverId:__ The Unique Server ID

**Best Practice：**
> 1. Normally you don not need to use this method if you have passed the server ID in another method. 

### <a name="showConversation"></a>10. Launch manual chat console, use `showConversation` (need to set [`UserName`](#UserName)) :<br />

	[ECServiceSdk showConversation:playerUid ServerId:serverId];

or

	[ECServiceSdk showConversation:playerUid 
					ServerId:serverId 
					Config:config];
	
**Coding Example：**

	[ECServiceSdk setUserName:@"PLAYER_NAME"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	NSMutableDictionary *customData = [NSMutableDictionary dictionary];
	[customData setObject:@"vip,pay1" forKey:@"elva-tags"];
	[customData setObject:@"1.0.0" forKey:@"VersionCode"];
	[config setObject:customData forKey:@"elva-custom-metadata"];
	[ECServiceSdk showConversation:@"PLAYER_ID" 
					ServerId:@"123" 
					Config:config];

**About Parameters：**

- __playerUid__:Unique User ID
- __serverId:__ The Unique Server ID
- __config__: Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.

**Best Practice：**
> 1. Normally you don not need to use this method unless you intend to allow users to enter manual conversations without engaging with the AI chat. You may use this method as a privilege for some users.

![showConversation](https://github.com/AIHELP-NET/Pictures/blob/master/showConversation-EN-iOS.png "showConversation")


### <a name="setSDKLanguage"></a>11. Set the SDK Language, use `setSDKLanguage`:<br />

Setting the SDK Language will change the FAQs, Operational information, AI Chat and SDK display language. 

	[ECServiceSdk setSDKLanguage:language];
	
**Coding Example：**

	[ECServiceSdk setSDKLanguage:@"en"];

**About Parameters：**

- __language:__ Standard Language Alias. For example: en is for English, zh_CN is for Simplified Chinese. More language labels can be viewed at [AIHelp Web Console](https://aihelp.net/elva):"Settings"-->"Language"->Alias.

![language](https://github.com/AI-HELP/Docs-Screenshots/blob/master/Language-alias.png "Language Alias")

**Best Practice：**
> 1. Normally AIHelp will use the mobile's language configuration by default. If you intend to make a different language setting, you need to use this method right after the SDK initialization.
> 2. If your allow users to change the APP language, then you need to use this method to make AIHelp the same lanague as your APP.

### 12. Set a Different Greeting Story Line.

If your APP provides multiple entries to AIHelp, and you intend to introduce different AI welcome texts and story lines to users from different entries, you can set config parameter in [showElva](#showElva) or [showElvaOP](#showElvaOP)： 

	NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
	[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];

**Coding Example：**

	NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
	
	// note：anotherWelcomeText is key, should be unchanged.
	// you need to change usersay according to the "User Say" in your new 
	// story line
	[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];
	NSMutableDictionary *config = [NSMutableDictionary dictionary];
	[config setObject:welcomeText forKey:@"elva-custom-metadata"];
	

	[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
                  PlayerUid:@"TEST_UID_123"
                  ServerId:@"TEST_SRV_ID_123"
                  PlayerParseId:@""
                  PlayershowConversationFlag:@"1"
                  Config:config];
Or

	[ECServiceSdk showElvaOP:@"TEST_PLAYER_NAME"
                  PlayerUid:@"TEST_UID_123"
                  ServerId:@"TEST_SRV_ID_123"
                  PlayerParseId:@""
                  PlayershowConversationFlag:@"1"
                  Config:config];


**Best Practice：**
> 1. Introduce different story lines to users from different sources.
