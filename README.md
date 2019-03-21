[中文版接入文档](https://github.com/AI-HELP/iOS-SDK-stable/blob/master/README_CN.md)
# AIHelp iOS SDK Integration Guide
1. SDK supports iOS versions 8 and above.
## Ⅰ. Download iOS SDK
Click the button "Clone or download" in the top right corner to download iOS SDK and then unzip the file.
## Ⅱ. Import ElvaChatServiceSDK into project
1. Copy the ElvaChatServiceSDK folder to your main directory.
## Ⅲ. Project Settings
1. Add `-ObjC` to Build Settings-Other Linker Flags.
2. Add framework to Link Binary with Libraries: `webkit.framework`.
3. Add framework to Link Binary with Libraries: `libsqlite3.tbd`.
3. Add framework to Link Binary with Libraries: `libc++.tbd`.
4. Please check the **Info.plist** and **TARGETS->info->Custom iOS Target Properties** in your project file for these permissions:<br>
    `Privacy - Camera Usage Description` <br>
    `Privacy - Photo Library Usage Description`<br>
    IOS 11 needs to add permissions to **info. plist** of the project:<br>
    `Privacy - Photo Library Additions Usage Description`<br>
## Ⅳ. API Summary:
| Method | Purpose |Prerequisites|
|:------------- |:---------------|:---------------|
| [**init**](#init)      | SDK initialization | 
| [**showElva**](#showElva)      | Launch AI Conversation Interface|
| [**showConversation**](#showConversation)|Launch Manual Conversation Interface| Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showElvaOP**](#showElvaOP) | Launch Operation Interface| Need to configure Operation Sections|
| [**showFAQs**](#showFAQs) | Show all FAQs by Sections|Need to Configure FAQs,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showFAQSection**](#showFAQSection)| Show FAQ Section|Need to Configure FAQs,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showSingleFAQ**](#showSingleFAQ) | Show Single FAQ|Need to Configure FAQ,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**setName**](#setName) |Set Your App's Name for AIHelp SDK to Display|Use it After Initialization|
| [**setUserId**](#setUserId) | Set unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
| [**setUserName**](#setUserName) | Set User In-App Name.If there is no uname,use string @"",The system uses the default nickname "anonymous"|
| [**setServerId**](#setServerId) | Set Unique Server ID|
| [**setSDKLanguage**](#setSDKLanguage) | Set SDK Language|
| [**setRootViewController**](#setRootViewController) | Set up a view controller for popping up 'AIHelp'|

**Note：It is not necessary for you to use all the APIs, especially when you only have one user interface for the customer service in your application. Some APIs already contains entry to other APIs, see below for details**






# Start using SDK

##  <a name="init"></a>1. SDK initialization（Must be called during application/game initialization, otherwise you can't use AIHelp properly）<br>
1. Introduce header file `#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>`
2.  In the `application: didFinishLaunchingWithOptions`method of `AppDelegate` of the project, the SDK initialization method is invoked.
        
        [ECServiceSdk init:appSecret 
                    Domain:domain
                    AppId:appId];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
| **appSecret**    | Your unique Developer API Key|
| **domain**     | Your AIHelp Domain Name. For example: foo.AIHELP.NET|
| **appId**     | A unique ID Assigned to your App.| 

Note: Please log into [AIHelp Web Console](https://aihelp.net/elva) with your registered email account to find the __appKey__, __domain__ and __appId__ In the _Application_ page of the _Settings_ Menu. 
If your company doesn't have an account, you need to register an account at [AIHelp Website](http://aihelp.net/index.html)

**Coding Example：**

```
// Must be called during application/game initialization, otherwise you can't use AIHelp properly.
[ECServiceSdk init:@"YOUR_API_KEY"
            Domain:@"YOUR_DOMAIN_NAME"
            AppId:@"YOUR_APP_ID"];
```





## <a name="showElva"></a>2. Launch the AI Conversation Interface, Use `showElva`:<br />

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

    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];

    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

    [ECServiceSdk showElva:@"USER_NAME"
                PlayerUid:@"USER_ID"
                ServerId:@"123"
                PlayerParseId:@""
                PlayershowConversationFlag:@"1"
                Config:config];

    /* `config` sample content
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
    
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerName__|In-App User Name.If there is no uname,use string @"",The system uses the default nickname "anonymous"|
|__playerUid__|In-App Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
|__serverId__|The Server ID|
|__playerParseId__|Can be empty string, can NOT be NULL.|
|__showConversationFlag__|Should be "0" or "1". If set "1", the manual conversation entry will be displayed in the upper right hand side of the AI conversation interface.|
|__config__|Optional parameters for custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note you also need to configure the same tag information in the Web console so that each conversation can be correctly tagged.|

![showElva](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElva-EN-IOS.jpg "showElva")

**Best Practice：**

> 1. Use this method to launch your APP's customer service. Configure specific welcome texts and AI story lines in the AIHelp Web Console to better the customer support experiences.
> 2. Enable Manual Conversation Entry to allow users' to chat with your human support team with the  parameter "__showConversationFlag__" setting to "__1__", you may use this method for any user or as a privilege for some users only.





## <a name="showConversation"></a>3. Launch manual chat console, use `showConversation` (need to set [`UserName`](#UserName)) :<br />

    [ECServiceSdk showConversation:playerUid ServerId:serverId];

or

    [ECServiceSdk showConversation:playerUid ServerId:serverId Config:config];

**Coding Example：**

    [ECServiceSdk setUserName:@"PLAYER_NAME"];  //This method needs to be invoked first
    
    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];

    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

    [ECServiceSdk showConversation:@"PLAYER_ID" 
                        ServerId:@"123" 
                        Config:config];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerUid__|Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
|__serverId:__|The Unique Server ID|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|

![showConversation](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showConversation-EN-IOS.png "showConversation")

**Best Practice：**
> 1. Normally you don not need to use this method unless you intend to allow users to enter manual conversations without engaging with the AI chat. You may use this method as a privilege for some users.








## <a name="showElvaOP"></a>4. Launch The Operation Interface, use `showElvaOP`:<br />
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

    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];

    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers
    
    [ECServiceSdk showElvaOP:@"USER_NAME" 
                    PlayerUid:@"USER_ID" 
                    ServerId:@"123" 
                    PlayerParseId:@"" 
                    PlayershowConversationFlag:@"1" 
                    Config:config];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerName__|User Name in Game/APP.If there is no uname,use string @"",The system uses the default nickname "anonymous"|
|__playerUid__|Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
|__serverId__|The Server ID|
|__playerParseId__|Can be empty string, can NOT be NULL.|
|__showConversationFlag__|Should be "0" or "1". If set at "1", the manual conversation entry will be shown in the top right-hand corner of the AI conversation interface.|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console so that each conversation can be correctly tagged.|
|__defaultTabIndex__|Optional. The index of the first tab will to be shown when entering the operation interface. Default value is 0, default value of is the left-most tab, if you would like to show the AI conversation interface(the right-most) should be set to 999.|

![showElvaOP](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElvaOP_Android.png "showElvaOP")

**Best Practice：**
> 1. Use this API to present news, announcements, articles or any useful information to users/players. Configure and publish the information in AIHelp web console. 










## <a name="showFAQs"></a>5. Display FAQs, use `showFAQs` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />

	[ECServiceSdk showFAQs];

or

	[ECServiceSdk showFAQs:config];

**Coding Example：**

    // Presenting FAQs to your customers
    [ECServiceSdk setUserName:@"PLAYER_NAME"];
    [ECServiceSdk setUserId:@"123ABC567DEF"];
    
    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];
    
    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters
    
    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers
    
    BOOL isShowRobot = YES;
    BOOL isShowConversation = YES;
    //Display `robot` and `conversation` entrance
    if (isShowRobot && isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
        [config setObject:@"1" forKey:@"showConversationFlag"];
    }
    //Display `robot` entrance
    else if (isShowRobot && !isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
    }
    //Display `conversation` entrance
    else if (!isShowRobot && isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
        [config setObject:@"1" forKey:@"directConversation"];
    }
    [ECServiceSdk showFAQs:config];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|
	
![showFAQs](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQs-EN-IOS.jpg "showFAQs")

**Best Practice：**
> 1. Use this method to show FAQs about your APP/Game properly. Configure FAQs in AIHelp Web Console. Each FAQ can be categroized into a section. If the FAQs are great in number, you can also add Parent Sections to categorize sections to make things clear and organized. 



## <a name="showFAQSection"></a>6. Display section "FAQ", use `showFAQSection` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />


    [ECServiceSdk showFAQSection:sectionPublishId];

or

    [ECServiceSdk showFAQSection:sectionPublishId Config:config];

**Coding Example：**

    // Presenting FAQs to your customers
    [ECServiceSdk setUserName:@"PLAYER_NAME"];
    [ECServiceSdk setUserId:@"123ABC567DEF"];

    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];

    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

    BOOL isShowRobot = YES;
    BOOL isShowConversation = YES;
    //Display `robot` and `conversation` entrance
    if (isShowRobot && isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
        [config setObject:@"1" forKey:@"showConversationFlag"];
    }
    //Display `robot` entrance
    else if (isShowRobot && !isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
    }
    //Display `conversation` entrance
    else if (!isShowRobot && isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
        [config setObject:@"1" forKey:@"directConversation"];
    }
    [ECServiceSdk showFAQSection:@"100" Config:config];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__sectionPublishId__|The PublishID of the FAQ item, you can check it at [AIHelp Web Console](https://aihelp.net/elva): Find the FAQ in the FAQ menu and copy its PublishID.|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|

![showFAQSection](https://github.com/CS30-NET/Pictures/blob/master/showFAQSection-CN-IOS.jpg "showFAQSection")






## <a name="showSingleFAQ"></a>7. Show A Specific FAQ, use `showSingleFAQ` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />

	[ECServiceSdk showSingleFAQ:faqId];

or

	[ECServiceSdk showSingleFAQ:faqId Config:config];

**Coding Example：**

    // Presenting FAQs to your customers
    [ECServiceSdk setUserName:@"PLAYER_NAME"];
    [ECServiceSdk setUserId:@"123ABC567DEF"];

    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];

    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

    BOOL isShowRobot = YES;
    BOOL isShowConversation = YES;
    //Display `robot` and `conversation` entrance
    if (isShowRobot && isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
        [config setObject:@"1" forKey:@"showConversationFlag"];
    }
    //Display `robot` entrance
    else if (isShowRobot && !isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
    }
    //Display `conversation` entrance
    else if (!isShowRobot && isShowConversation) {
        [config setObject:@"1" forKey:@"showContactButtonFlag"];
        [config setObject:@"1" forKey:@"directConversation"];
    }
	[ECServiceSdk showSingleFAQ:@"20" Config:config];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__faqId__|Number of FAQ. Open [AIHelp Background](https://aihelp.net/elva) and find the FAQ number of the specified FAQ under the **Robot Frequent Questions** page. Note that this FAQID cannot fill in the FAQ number that does not exist in the customer service backstage.|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|
	
![showSingleFAQ](https://github.com/AI-HELP/Docs-Screenshots/blob/master/showSingleFAQ-EN-IOS.jpg "showSingleFAQ")

**Best Practice：**
> 1. Use this method when you want to show a specific FAQ in a proper location of your APP/Game.



## <a name="setName"></a>8. Set Your App's Name for AIHelp SDK to Display, use `setName`:<br />

	[ECServiceSdk setName:game_name];

**Coding Example：**

	[ECServiceSdk setName:@"Your Game"];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__game_name__|APP/Game Name|

**Best Practice：**
> 1. Use this method after the SDK initialization.The App's name will be displayed in the title bar of the customer service interface.






## <a name="setUserId"></a>9. Set the Unique User ID, use `setUserId`:<br />

	[ECServiceSdk setUserId:playerUid];

**Coding Example：**

	[ECServiceSdk setUserId:@"123ABC567DEF"];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerUid__|Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|

**Best Practice：**
> 1. Normally you don not need to use this method if you have passed the user ID in another method.






## <a name="setUserName"></a>10. Set User Name, use `setUserName`:<br />

	[ECServiceSdk setUserName:playerName];

**Coding Example：**

	[ECServiceSdk setUserName:@"PLAYER_NAME"];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerName__|User/Player Name.If there is no uname,use string @"",The system uses the default nickname "anonymous"|

**Best Practice：**
> 1. Use this method to set the user name, which will be shown in the web console's conversation page for the user. You can address the user with this name during the chat.
> 2. Normally you don't need to use this method if you have passed user name in other method. 






## <a name="setServerId"></a>11. Set Unique Server ID, use `setServerId`:<br />

	[ECServiceSdk setServerId:serverId];

**Coding Example：**

	[ECServiceSdk setServerId:@"SERVER_ID"];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__serverId__|The Unique Server ID|

**Best Practice：**
> 1. Normally you don not need to use this method if you have passed the server ID in another method. 






## <a name="setSDKLanguage"></a>12. Set the SDK Language, use `setSDKLanguage`:<br />

Setting the SDK Language will change the FAQs, Operational information, AI Chat and SDK display language. 

	[ECServiceSdk setSDKLanguage:language];
	
**Coding Example：**

	[ECServiceSdk setSDKLanguage:@"en"];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__language__|Standard Language Alias. For example: en is for English, zh_CN is for Simplified Chinese. More language labels can be viewed at [AIHelp Web Console](https://aihelp.net/elva):"Settings"-->"Language"->Alias.|

![language](https://github.com/AI-HELP/Docs-Screenshots/blob/master/Language-alias.png "Language Alias")

**Best Practice：**
> 1. Normally AIHelp will use the mobile's language configuration by default. If you intend to make a different language setting, you need to use this method right after the SDK initialization.
> 2. If your allow users to change the APP language, then you need to use this method to make AIHelp the same lanague as your APP.





## <a name="setRootViewController"></a>13. setRootViewController, use `setRootViewController`:<br />


**Coding Example：**

    [ECServiceSdk setRootViewController:viewController];

**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__viewController__|Set up a view controller for popping up 'AIHelp'|

**Best Practice：**
> 1. If there are multiple windows and the interface such as showElva is called directly, the interface is called when the page cannot pop up.





##  Set a Different Greeting Story Line.

If your APP provides multiple entries to AIHelp, and you intend to introduce different AI welcome texts and story lines to users from different entries, you can set config parameter in [showElva](#showElva) or [showElvaOP](#showElvaOP)： 

	NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
	[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];

**Coding Example：**

    NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
    [tags addObject:@"vip"];
    [tags addObject:@"pay1"];

    NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
    [customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
    [customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

    // note：anotherWelcomeText is key, should be unchanged.
    [customData setObject:@"usersay" forKey:@"anotherWelcomeText"]; //Set a Different Greeting Story Line
    
    NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
    [config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers


	

	[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
                  PlayerUid:@"TEST_UID_123"
                  ServerId:@"TEST_SRV_ID_123"
                  PlayerParseId:@""
                  PlayershowConversationFlag:@"1"
                  Config:config];
or

	[ECServiceSdk showElvaOP:@"TEST_PLAYER_NAME"
                  PlayerUid:@"TEST_UID_123"
                  ServerId:@"TEST_SRV_ID_123"
                  PlayerParseId:@""
                  PlayershowConversationFlag:@"1"
                  Config:config];

or
    
    [ECServiceSdk setUserName:@"PLAYER_NAME"];  
    [ECServiceSdk setUserId:@"123ABC567DEF"];   
    [ECServiceSdk showFAQs:config];

**Best Practice：**
> 1. Introduce different story lines to users from different sources.




