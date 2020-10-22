[中文版接入文档](https://github.com/AI-HELP/iOS-SDK-stable/blob/master/README_CN.md)
## AIHelp iOS SDK Integration Guide
1. SDK supports iOS versions 8 and above.
2. Party A is obliged to use Party B's services according to the correct plug-in method and calling method described by Party B's documents. If Party A uses any technical method to influence Party B's billing, Party B will have the right to notify Party A while unilaterally terminating the service immediately and ask Party A to assume responsibility for infulencing the billing of Party B.
### Ⅰ. Download iOS SDK
Click the button "Clone or download" in the top right corner to download iOS SDK and then unzip the file.
### Ⅱ. Import ElvaChatServiceSDK into project
1. Copy the ElvaChatServiceSDK folder to your main directory.
### Ⅲ. Project Settings
1. Add `-ObjC` to **Build Settings**->**Other Linker Flags**.
2. Add framework to **Link Binary with Libraries**:<br>
`WebKit.framework` 
`libsqlite3.tbd`  
`libresolv.tbd`
3. Please check the **Info.plist** and **TARGETS->info->Custom iOS Target Properties** in your project file for these permissions:<br>
`Privacy - Camera Usage Description` <br>
`Privacy - Photo Library Usage Description`<br>
`Privacy - Photo Library Additions Usage Description`<br>
`Privacy - Microphone Usage Description`<br>
###  IV、SDK initialization（Must be called during application initialization, otherwise you can't use AIHelp properly）
**Party A is obliged to use Party B's services according to the correct plug-in method and calling method described by Party B's documents. If Party A uses any technical method to influence Party B's billing, Party B will have the right to notify Party A while unilaterally terminating the service immediately and ask Party A to assume responsibility for infulencing the billing of Party B.**
1. Introduce header file `#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>`
2. In the `application: didFinishLaunchingWithOptions`method of `AppDelegate` of the project, the SDK initialization method is invoked.
```objc
[ECServiceSdk init:app_key 
            Domain:app_domain
             AppId:app_id];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
| **app_key**    | Your unique Developer API Key. Can be obtained from our web management system by `APP Key`|
| **app_domain** | Your AIHelp Domain Name. For example: foo.AIHELP.NET. Can be obtained from our web management system by `Domain`|
| **app_id**     | A unique ID Assigned to your App. Can be obtained from our web management system by `Platforms(AppID)`| 

Note: Please log into [AIHelp Web Console](https://aihelp.net/elva) with your registered email account to find the `APP Key`, `Domain` and `Platforms(AppID)` In the _Application_ page of the _Settings_ Menu. 
If your company doesn't have an account, you need to register an account at [AIHelp Website](http://aihelp.net/index.html)

**Coding Example：(Must be called during application initialization, otherwise you can't use AIHelp properly)**<br />
**Party A is obliged to use Party B's services according to the correct plug-in method and calling method described by Party B's documents. If Party A uses any technical method to influence Party B's billing, Party B will have the right to notify Party A while unilaterally terminating the service immediately and ask Party A to assume responsibility for infulencing the billing of Party B.**

```objc
[ECServiceSdk init:@"YOUR_API_KEY"
            Domain:@"YOUR_DOMAIN_NAME"
             AppId:@"YOUR_APP_ID"];
```




## Start using SDK
### 1. API Summary:
| Method | Purpose |Prerequisites|
|:------------- |:---------------|:---------------|
| [**showElva**](#showElva)      | Launch AI Conversation Interface|
| [**showConversation**](#showConversation)|Launch Manual Conversation Interface| Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showElvaOP**](#showElvaOP) | Launch Operation Interface| Need to configure Operation Sections|
| [**showFAQs**](#showFAQs) | Show all FAQs by Sections|Need to Configure FAQs,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showFAQSection**](#showFAQSection)| Show FAQ Section|Need to Configure FAQs,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**showSingleFAQ**](#showSingleFAQ) | Show Single FAQ|Need to Configure FAQ,Need to [setUserName](#setUserName) and [setUserId](#setUserId)|
| [**setSDKLanguage**](#setSDKLanguage) | Set SDK Language|By default, the phone system language setting is used, and the in-app setting language can be called after setting|
| [**setRootViewController**](#setRootViewController) | Set up a view controller for popping up 'AIHelp'|
| [**setSDKInterfaceOrientationMask**](#setSDKInterfaceOrientationMask) | SDK display orientation | Requite the orientation permissions of the device|
| [**setName**](#setName) |Set Your App's Name for AIHelp SDK to Display|Use it After Initialization|
| [**setUserId**](#setUserId) | Set unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
| [**setUserName**](#setUserName) | Set User In-App Name.If there is no uname,use string @"",The system uses the default nickname "anonymous"|
| [**setServerId**](#setServerId) | Set Unique Server ID|


**Note：It is not necessary for you to use all the APIs, especially when you only have one user interface for the customer service in your application. Some APIs already contains entry to other APIs, see below for details**






### <a name="showElva"></a>2. Launch the AI Conversation Interface, Use `showElva`:<br />
```objc
[ECServiceSdk showElva:playerName
             PlayerUid:playerUid
              ServerId:serverId
         PlayerParseId:playerParseId                
PlayershowConversationFlag:showConversationFlag];
```
or
```objc
[ECServiceSdk showElva:playerName
            PlayerUid:playerUid
             ServerId:serverId
        PlayerParseId:playerParseId
PlayershowConversationFlag:showConversationFlag
               Config:config];
```
**Coding Example：**
```objc
//You need to add the same label to'AIHelp Web Console'before it takes effect.
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
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerName__|In-App User Name.If there is no uname,use string @"",The system uses the default nickname "anonymous"|
|__playerUid__|In-App Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
|__serverId__|The Server ID|
|__playerParseId__|Can be empty string, can NOT be NULL.|
|__showConversationFlag__|Should be "0" or "1". If set "1", the manual conversation entry will be displayed in the upper right hand side of the AI conversation interface.|
|__config__|Optional parameters for custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note you also need to configure the same tag information in the Web console so that each conversation can be correctly tagged.|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElva-EN-IOS.png?raw=true" width="414" alt="showElva">

**Best Practice：**

> 1. Use this method to launch your APP's customer service. Configure specific welcome texts and AI story lines in the AIHelp Web Console to better the customer support experiences.
> 2. Enable Manual Conversation Entry to allow users' to chat with your customer support team with the  parameter "__showConversationFlag__" setting to "__1__", you may use this method for any user or as a privilege for some users only.





### <a name="showConversation"></a>3. Launch manual chat console, use `showConversation` (need to set [`UserName`](#UserName)) :<br />
```objc
[ECServiceSdk showConversation:playerUid ServerId:serverId];
```
or
```objc
[ECServiceSdk showConversation:playerUid ServerId:serverId Config:config];
```
**Coding Example：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];  //This method needs to be invoked first

//You need to add the same label to'AIHelp Web Console'before it takes effect.
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
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerUid__|Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|
|__serverId:__|The Unique Server ID|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showConversation-EN-IOS.png?raw=true" width="414" alt="showConversation">

**Best Practice：**
> 1. Normally you don not need to use this method unless you intend to allow users to enter manual conversations without engaging with the AI chat. You may use this method as a privilege for some users.








### <a name="showElvaOP"></a>4. Launch The Operation Interface, use `showElvaOP`:<br />
The operation module is useful when you want to present updates, news, articles or any background information about your APP/Game to users.
```objc
[ECServiceSdk showElvaOP:playerName 
               PlayerUid:playerUid 
                ServerId:serverId 
           PlayerParseId:playerParseId 
PlayershowConversationFlag:showConversationFlag 
                  Config:config];
```
or
```objc
[ECServiceSdk showElvaOP:playerName 
               PlayerUid:playerUid 
                ServerId:serverId 
           PlayerParseId:playerParseId 
PlayershowConversationFlag:showConversationFlag 
                  Config:config
         defaultTabIndex:defaultTabIndex];
```
**Coding Example：**
```objc
//You need to add the same label to'AIHelp Web Console'before it takes effect.
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
```
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

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showElvaOP-EN-IOS.png?raw=true" width="414" alt="showElvaOP">

**Best Practice：**
> 1. Use this API to present news, announcements, articles or any useful information to users. Configure and publish the information in AIHelp web console. 










### <a name="showFAQs"></a>5. Display FAQs, use `showFAQs` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />
```objc
[ECServiceSdk showFAQs];
```
or
```objc
[ECServiceSdk showFAQs:config];
```
**Coding Example：**
```objc
// Presenting FAQs to your customers
[ECServiceSdk setUserName:@"PLAYER_NAME"];
[ECServiceSdk setUserId:@"123ABC567DEF"];

//You need to add the same label to'AIHelp Web Console'before it takes effect.
NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
[customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
[config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

//I、Contact us button display logic
//    0、Default: Not displayed,In FAQ details page,Click the 'No' button to display the 'Contact Us' button.
//    1、Always displayed: set 'showContactButtonFlag', add below code to your source
//        [config setObject:@"1" forKey:@"showContactButtonFlag"];
//    2、Keep hiden: set the 'hideContactButtonFlag', add below code to your source
//        [config setObject:@"1" forKey:@"hideContactButtonFlag"];

//II、Click the contact us button
//    0、Default: Enter the robot page
//    1、Conversation: set 'directConversation', add below code to your source
//        [config setObject:@"1" forKey:@"directConversation"];
//    2、Robot+Conversation: set 'showConversationFlag', add below code to your source
//        [config setObject:@"1" forKey:@"showConversationFlag"];

[ECServiceSdk showFAQs:config];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQs-EN-IOS.png?raw=true" width="414" alt="showFAQs">

**Best Practice：**
> 1. Use this method to show FAQs about your APP/Game properly. Configure FAQs in AIHelp Web Console. Each FAQ can be categroized into a section. If the FAQs are great in number, you can also add Parent Sections to categorize sections to make things clear and organized. 



### <a name="showFAQSection"></a>6. Display section "FAQ", use `showFAQSection` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />

```objc
[ECServiceSdk showFAQSection:sectionPublishId];
```
or
```objc
[ECServiceSdk showFAQSection:sectionPublishId Config:config];
```
**Coding Example：**
```objc
// Presenting FAQs to your customers
[ECServiceSdk setUserName:@"PLAYER_NAME"];
[ECServiceSdk setUserId:@"123ABC567DEF"];

//You need to add the same label to'AIHelp Web Console'before it takes effect.
NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
[customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
[config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

//I、Contact us button display logic
//    0、Default: Not displayed,In FAQ details page,Click the 'No' button to display the 'Contact Us' button.
//    1、Always displayed: set 'showContactButtonFlag', add below code to your source
//        [config setObject:@"1" forKey:@"showContactButtonFlag"];
//    2、Keep hiden: set the 'hideContactButtonFlag', add below code to your source
//        [config setObject:@"1" forKey:@"hideContactButtonFlag"];

//II、Click the contact us button
//    0、Default: Enter the robot page
//    1、Conversation: set 'directConversation', add below code to your source
//        [config setObject:@"1" forKey:@"directConversation"];
//    2、Robot+Conversation: set 'showConversationFlag', add below code to your source
//        [config setObject:@"1" forKey:@"showConversationFlag"];

[ECServiceSdk showFAQSection:@"100" Config:config];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__sectionPublishId__|The PublishID of the FAQ item, you can check it at [AIHelp Web Console](https://aihelp.net/elva): Find the FAQ in the FAQ menu and copy its PublishID.|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showFAQSection-EN-IOS.png?raw=true" width="414" alt="showFAQSection">



### <a name="showSingleFAQ"></a>7. Show A Specific FAQ, use `showSingleFAQ` (need to set [`setUserName`](#setUserName) and set [`setUserId`](#setUserId)) :<br />
```objc
[ECServiceSdk showSingleFAQ:faqId];
```
or
```objc
[ECServiceSdk showSingleFAQ:faqId Config:config];
```
**Coding Example：**
```objc
// Presenting FAQs to your customers
[ECServiceSdk setUserName:@"PLAYER_NAME"];
[ECServiceSdk setUserId:@"123ABC567DEF"];

//You need to add the same label to'AIHelp Web Console'before it takes effect.
NSMutableArray * tags = [NSMutableArray array]; //Definition of `tag` container
[tags addObject:@"vip"];
[tags addObject:@"pay1"];

NSMutableDictionary *customData = [NSMutableDictionary dictionary];////Definition of `customData` container
[customData setObject:tags forKey:@"elva-tags"]; //Add `Tag` label
[customData setObject:@"1.0.0" forKey:@"VersionCode"];  //Add `custom` parameters

NSMutableDictionary *config = [NSMutableDictionary dictionary]; //Definition of `config` container
[config setObject:customData forKey:@"elva-custom-metadata"]; //Store `customData` in containers

//I、Contact us button display logic
//    0、Default: Not displayed,In FAQ details page,Click the 'No' button to display the 'Contact Us' button.
//    1、Always displayed: set 'showContactButtonFlag', add below code to your source
//        [config setObject:@"1" forKey:@"showContactButtonFlag"];
//    2、Keep hiden: set the 'hideContactButtonFlag', add below code to your source
//        [config setObject:@"1" forKey:@"hideContactButtonFlag"];

//II、Click the contact us button
//    0、Default: Enter the robot page
//    1、Conversation: set 'directConversation', add below code to your source
//        [config setObject:@"1" forKey:@"directConversation"];
//    2、Robot+Conversation: set 'showConversationFlag', add below code to your source
//        [config setObject:@"1" forKey:@"showConversationFlag"];

[ECServiceSdk showSingleFAQ:@"20" Config:config];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__faqId__|Number of FAQ. Open [AIHelp Background](https://aihelp.net/elva) and find the FAQ number of the specified FAQ under the **Robot Frequent Questions** page. Note that this FAQID cannot fill in the FAQ number that does not exist in the customer service backstage.|
|__config__|Custom Dictionary information. You can pass specific Tag information using vector elva-tags, see the above coding example. Please note that you also need to configure the same tag information in the Web console to make each conversation be correctly tagged.|

Note:If the FAQ's SelfServiceInterface is configured in the AIHelp background, and the SDK is configured with related parameters, the FAQ will be displayed, and the function menu will be provided in the upper right corner to call the related self-service.

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/showSingleFAQ-EN-IOS.png?raw=true" width="414" alt="showSingleFAQ">

**Best Practice：**
> 1. Use this method when you want to show a specific FAQ in a proper location of your APP/Game.



### <a name="setName"></a>8. Set Your App's Name for AIHelp SDK to Display, use `setName`:<br />
```objc
[ECServiceSdk setName:game_name];
```
**Coding Example：**
```objc
[ECServiceSdk setName:@"Your Game"];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__game_name__|APP/Game Name|

**Best Practice：**
> 1. Use this method after the SDK initialization.The App's name will be displayed in the title bar of the customer service interface.






### <a name="setUserId"></a>9. Set the Unique User ID, use `setUserId`:<br />
```objc
[ECServiceSdk setUserId:playerUid];
```
**Coding Example：**
```objc
[ECServiceSdk setUserId:@"123ABC567DEF"];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerUid__|Unique User ID.If there is no uid,use string @"",The system automatically generates a unique user ID|

**Best Practice：**
> 1. Normally you do not need to use this method if you have passed the user ID in another method.






### <a name="setUserName"></a>10. Set User Name, use `setUserName`:<br />
```objc
[ECServiceSdk setUserName:playerName];
```
**Coding Example：**
```objc
[ECServiceSdk setUserName:@"PLAYER_NAME"];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__playerName__|User Name.If there is no uname,use string @"",The system uses the default nickname "anonymous"|

**Best Practice：**
> 1. Use this method to set the user name, which will be shown in the web console's conversation page for the user. You can address the user with this name during the chat.
> 2. Normally you don't need to use this method if you have passed user name in other method. 






### <a name="setServerId"></a>11. Set Unique Server ID, use `setServerId`:<br />
```objc
[ECServiceSdk setServerId:serverId];
```
**Coding Example：**
```objc
[ECServiceSdk setServerId:@"SERVER_ID"];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__serverId__|The Unique Server ID|

**Best Practice：**
> 1. Normally you don not need to use this method if you have passed the server ID in another method. 






### <a name="setSDKLanguage"></a>12. Set the SDK Language, use `setSDKLanguage`:<br />

Setting the SDK Language will change the FAQs, Operational information, AI Chat and SDK display language. 
```objc
[ECServiceSdk setSDKLanguage:language];
```    
**Coding Example：**
```objc
[ECServiceSdk setSDKLanguage:@"en"];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__language__|Standard Language Alias. For example: en is for English, zh_CN is for Simplified Chinese. More language labels can be viewed at [AIHelp Web Console](https://aihelp.net/elva):"Settings"-->"Language"->Alias.|

<img src="https://github.com/AI-HELP/Docs-Screenshots/blob/master/Language-alias.png?raw=true" width="414" alt="Language Alias">


**Best Practice：**
> 1. Normally AIHelp will use the mobile's language configuration by default. If you intend to make a different language setting, you need to use this method right after the SDK initialization.
> 2. If your allow users to change the APP language, then you need to use this method to make AIHelp the same lanague as your APP.









###  13.Set a Different Greeting Story Line.

If your APP provides multiple entries to AIHelp, and you intend to introduce different AI welcome texts and story lines to users from different entries, you can set config parameter in [showElva](#showElva) or [showElvaOP](#showElvaOP)： 
```objc
NSMutableDictionary *welcomeText = [NSMutableDictionary dictionary];
[welcomeText setObject:@"usersay" forKey:@"anotherWelcomeText"];

**Coding Example：**

//You need to add the same label to'AIHelp Web Console'before it takes effect.
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
```


```objc
[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
             PlayerUid:@"TEST_UID_123"
              ServerId:@"TEST_SRV_ID_123"
         PlayerParseId:@""
PlayershowConversationFlag:@"1"
                Config:config];
```
or
```objc
[ECServiceSdk showElvaOP:@"TEST_PLAYER_NAME"
               PlayerUid:@"TEST_UID_123"
                ServerId:@"TEST_SRV_ID_123"
           PlayerParseId:@""
PlayershowConversationFlag:@"1"
                  Config:config];
```
or
```objc   
[ECServiceSdk setUserName:@"PLAYER_NAME"];  
[ECServiceSdk setUserId:@"123ABC567DEF"];   
[ECServiceSdk showFAQs:config];
```
**Best Practice：**
> 1. Introduce different story lines to users from different sources.


### 14.Set different artificial greetings

 If you want to customize the welcome message of the manual customer service, you need to pass a new pair of keys in the configuration parameters of the corresponding interface. The key is: "private_welcome_str", valued for the customized content you want
**code example：**
```objc
NSMutableDictionary *customData = [NSMutableDictionary dictionary];
// note:private_welcome_str is key, should be unchanged.
[customData setObject:@"usersay" forKey:@"private_welcome_str"];//Set different artificial greetings

NSMutableDictionary *config = [NSMutableDictionary dictionary]; 
[config setObject:customData forKey:@"elva-custom-metadata"];

[ECServiceSdk showElva:@"TEST_PLAYER_NAME"
             PlayerUid:@"TEST_UID_123"
              ServerId:@"TEST_SRV_ID_123"
         PlayerParseId:@""
PlayershowConversationFlag:@"1"
                Config:config];
```
**Best Practice：**
> 1. Introduce different story lines to users from different sources.





### <a name="setRootViewController"></a>15. setRootViewController, use `setRootViewController`:<br />


**Coding Example：**
```objc
[ECServiceSdk setRootViewController:viewController];
```
**About Parameters：**

| Parameters | Description |
|:------------- |:---------------|
|__viewController__|Set up a view controller for popping up 'AIHelp'|

**Best Practice：**
> 1. If there are multiple windows and the interface such as showElva is called directly, the interface is called when the page cannot pop up.





### <a name="setSDKInterfaceOrientationMask"></a>16.Set SDK display orientation
##### I、Set orientation permissions
**case 1**: Click `Project`->`General`->`Deployment Info`->`Device Orientation`
and enable
`Portrait`,`Upside Down`,`Upside Down`,`Landscape Right`
**case 2**: In `AppDelegate`,add
`application:supportedInterfaceOrientationsForWindow:` method and returns the device orientations that the device needs to support
  
```objc
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}
```
**Note:**<br />
1:The camera and photo album functions are used to upload pictures in the form. You must enable the `UIInterfaceOrientationMaskPortrait` option, otherwise the application will crash when calling the camera function.<br />
2:If the game is in landscape orientation and the vertical screen permission is enabled, which affects the orientation of the game, you can add the `supportedInterfaceOrientations` method to the `RootViewController.m` file and return the supported orientation of the game
```objc
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
```
##### II、SDK display orientation
**code example：**
```objc
//demo 1  Support all orientations in SDK display orientation setting
[ECServiceSdk setSDKInterfaceOrientationMask:UIInterfaceOrientationMaskAll];

//demo 2  Support landscape orientation in SDK display orientation setting
[ECServiceSdk setSDKInterfaceOrientationMask:UIInterfaceOrientationMaskLandscape];

//demo 3  Support vertical orientations in SDK display orientation setting
[ECServiceSdk setSDKInterfaceOrientationMask:UIInterfaceOrientationMaskPortrait];
```
**About Parameters:**
```objc
typedef NS_OPTIONS(NSUInteger, UIInterfaceOrientationMask) {
    UIInterfaceOrientationMaskPortrait,     
    UIInterfaceOrientationMaskLandscapeLeft,    
    UIInterfaceOrientationMaskLandscapeRight,   
    UIInterfaceOrientationMaskPortraitUpsideDown,
    UIInterfaceOrientationMaskLandscape,        
    UIInterfaceOrientationMaskAll,              
    UIInterfaceOrientationMaskAllButUpsideDown
}
```








## LICENSE

```
Copyright 2015 ShareFun Network Limited.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
