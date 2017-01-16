# HIGHLIGHTS<br />
1.Remember to initialize, otherwise the user can not enter Elva intelligent customer service system.<br />
2.<div>
    <table border="0">
      <tr>
        <th>Method</th>
        <th>showElva</th>
        <th>showConversation</th>
        <th>showFAQs</th>
        <th>showFAQSection</th>
        <th>showSingleFAQ</th>
      </tr>
      <tr>
        <td>Purpose</td>
        <td>Start the main robot interface</td>
        <td>Open the manual CS interface</td>
        <td>Show FAQ list</td>
        <td>Show Section</td>
        <td>Show a single FAQ</td>
      </tr>
    </table>
</div>
# IOS SDK Access Instructions
## Ⅰ. Download IOS SDK
Click the button "Clone or download" in the top right corner to download IOS SDK and then unzip the file.
## Ⅱ. cocos2dx Interface List
Put ECServiceCocos2dx.h, ECServiceCocos2dx.mm in the interface folder in your Classes folder.
## Ⅲ. Import elvachatservice into project
Copy the elvachatservice folder to your main directory.
## Ⅳ. Access Project Configuration
Modify info.list, ensure that the value of Allow Arbitrary Loads is YES (HTTP support is required for initialization).
## Ⅴ.Interface Call Instructions
### 1. SDK initialization. (must be called at the beginning of the game)
Call ECServiceCocos2dx::init(string appKey,string domain,string appId) in Cocos2dx.
* Parameter Description:<br />
app Key: The app key, obtained from the Web management system.<br />
domain: app Domain name, obtained from the Web management system.<br />
appId: app Unique identifier, obtained from the Web management system.<br />
Note: The latter three parameters, please use the registered email address to login https://cs30.net/elva. View in the Settings-Applications page. Initial use, please register on the official website http://cs30.net/preview/index.html.

### 2. The interface call method
> 
> 1) Start smart customer service main interface, call `showElva` method, start the robot interface.<br />
ECServiceCocos2dx :: showElva (string playerName, string playerUid, int serverId, string playerParseId, string showConversationFlag, cocos2d :: ValueMap & config);
* Parameter Description:<br />
playerName: The name of the player in the game.<br />
playerUid: The player's unique id in the game.<br />
serverId: The server ID of the player.<br />
playerParseId:Null.<br />
showConversationFlag (0 or 1): whether VIP, 0: marked non-VIP; 1: VIP. Here is 1, will be in the upper right corner of the robot chat interface, to provide artificial chat entry function.<br />
config: Optional, custom ValueMap information. You can set specific Tag information here.<br />
![showElva](https://github.com/CS30-NET/Pictures/blob/master/showElva-EN-IOS.jpg "showElva")
* Parameter Example:    

    ECServiceCocos2dx :: showElva ( "elvaTestName", "12349303258", 1, "es234-3dfs-d42f-342sfe3s3", "1"
     {
       Hs-custom-metadata = {
       Hs-tags = 'army, recharge'. //Note: hs-tags value is vector type, where the incoming custom Tag,   
       need to configure the same name in the Web management Tag to take effect.
       VersionCode = '3'
       }
      }
    );
> 
> 2) Show a single FAQ, call `showSingleFAQ` method<br />
ECServiceCocos2dx :: showSingleFAQ (string faqId, cocos2d :: ValueMap & config);
* Parameter Description:
faqId: FAQ's PublishID, in the Web background https://cs30.net/elva, from the FAQs menu to find the specified FAQ, view PublishID.<br />
config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts.<br />
Note: If the SelfServiceInterface is configured in the web administration background, and the SDK is configured with related parameters, the FAQ will be displayed and the function menu will be provided in the upper right corner to call up the related self-service.<br />
![showSingleFAQ](https://github.com/CS30-NET/Pictures/blob/master/showSingleFAQ-EN-IOS.jpg "showSingleFAQ")
> 
> 3) Show the relevant part of the FAQ, call `showFAQSection` method<br />
ECServiceCocos2dx :: showFAQSection (string sectionPublishId, cocos2d :: ValueMap & config);
* Parameter Description:
sectionPublishId: PublishID of the FAQ Section (PublishID can be viewed from the [Section] menu in the FAQs menu at https://cs30.net/elva).<br />
config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts.<br />
![showFAQSection](https://github.com/CS30-NET/Pictures/blob/master/showFAQSection-EN-IOS.jpg "showFAQSection")
> 
> 4) Show the FAQ list, call `showFAQs` method<br />
ECServiceCocos2dx :: showFAQs (cocos2d :: ValueMap & config);
* Parameter Description:<br />
config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts.<br />
![showFAQs](https://github.com/CS30-NET/Pictures/blob/master/showFAQs-EN-IOS.jpg "showFAQs")
> 
> 5) set the game name information, call `setName` method (It is recommended to call this method after calling init)<br />   
ECServiceCocos2dx :: setName (string game_name);
* Parameter Description:<br />
game_name: The name of the game, which will be displayed in the title bar of the relevant interface in the SDK.
> 
> 6) Set Token, use google push, call `registerDeviceToken` method (no)<br />
ECServiceCocos2dx :: registerDeviceToken (string deviceToken);
* Parameter Description:<br />
deviceToken: The device Token.
> 
> 7) Set the user id information, call the `setUserId` method (using self-service must call, see 2) show a single FAQ)<br />
Call ECServiceCocos2dx :: setUserId (string playerUid) before showSingleFAQ;
* Parameter Description:<br />
playerUid: The player unique ID.
> 
> 8) Set the server number information, call `setServerId` method (using self-service must call, see 2) show a single FAQ)<br />
Call ECServiceCocos2dx :: setServerId (int serverId) before showSingleFAQ
* Parameter Description:<br />
serverId: Server ID.
> 
> 9) Set the player name information, call `setUserName` method (It is recommended to call this method after calling init)<br />
ECServiceCocos2dx :: setUserName (string playerName);
* Parameter Description:<br />
playerName: The player name.
> 
> 10) Direct vip_chat artificial customer service chat, call `showConversation` method (must ensure that setUserName in 9) set the player name information has been called)<br />
ECServiceCocos2dx :: showConversation (string playerUid, int serverId, cocos2d :: ValueMap & config);
* Parameter Description:<br />
playerUid: The player's unique id in the game<br />
serverId: The server ID of the player.<br />
config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts.<br />
![showConversation](https://github.com/CS30-NET/Pictures/blob/master/showConversation-EN-IOS.png "showConversation")
