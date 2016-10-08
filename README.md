  Android SDK access instructions for English: https://github.com/CS30-NET/android-sdk-stable/blob/master/README.md
  
  中文版Android SDK接入说明：https://github.com/CS30-NET/android-sdk-stable/blob/master/README-CN.md
# IOS SDK Access Instructions
# Ⅰ. cocos2dx Interface List
    Put ECServiceCocos2dx.h, ECServiceCocos2dx.mm in the Classes folder
# Ⅱ. Import elvachatservice into project
    Copy the elvachatservice folder to your main directory，created as 'create groups for any added folders'.
# Ⅲ. The access project configuration
    Modify the info.list, ensure that the value of Allow Arbitrary Loads is YES (HTTP support is required for initialization)
# Ⅳ.The interface call instructions
    1. SDK initialization. (must be called at the beginning of the game)
      a. Call ECServiceCocos2dx::init(string appKey,string domain,string appId) in Cocos2dx.
        Parameter Description:
         app Key: The app key, obtained from the Web management system.
         domain: app Domain name, obtained from the Web management system.
         appId: app Unique identifier, obtained from the Web management system.
        Note: The latter three parameters, please use the registered email address to login https://cs30.net/elva. View in the Settings
        Applications page. Initial use, please register on the official website http://www.cs30.net/en/index.html.
        
    2. The interface call method
      1) Start smart customer service main interface, call showElva method, start the robot interface.
        ECServiceCocos2dx :: showElva (string playerName, string playerUid, int serverId, string playerParseId, string showConversationFlag, cocos2d :: ValueMap & config);
        Parameter Description:
          playerName: The name of the player in the game.
          playerUid: The player's unique id in the game.
          serverId: The server ID of the player.
          playerParseId: Push token.
          showConversationFlag (0 or 1): whether VIP, 0: marked non-VIP; 1: VIP. 
          Here is 1, will be in the upper right corner of the robot chat interface, to provide artificial chat entry function.
          config: Optional, custom ValueMap information. You can set specific Tag information here.
        Parameter Example:
          ECServiceCocos2dx :: showElva ( "elvaTestName", "12349303258", 1, "es234-3dfs-d42f-342sfe3s3", "1"
          {
            Hs-custom-metadata = {
              Hs-tags = 'army, recharge'. //Note: hs-tags value is vector type, where the incoming custom Tag, need to configure the same name in the Web management Tag to take effect.
              VersionCode = '3'
              }}
          }}
        );
      2) Show a single FAQ, call showSingleFAQ method
         ECServiceCocos2dx :: showSingleFAQ (string faqId, cocos2d :: ValueMap & config);
         Parameter Description:
          faqId: FAQ's PublishID, in the Web background https://cs30.net/elva, from the FAQs menu to find the specified FAQ, view PublishID.
          config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts
         Note: If the SelfServiceInterface is configured in the web administration background, and the SDK is configured with related
         parameters, the FAQ will be displayed and the function menu will be provided in the upper right corner to call up the related
         self-service.
      3) Show the relevant part of the FAQ, call showFAQSection method
         ECServiceCocos2dx :: showFAQSection (string sectionPublishId, cocos2d :: ValueMap & config);
         Parameter Description:
          sectionPublishId: PublishID of the FAQ Section (PublishID can be viewed from the [Section] menu in the FAQs menu at
          https://cs30.net/elva)
          config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts
      4) Show the FAQ list, call showFAQs method
         ECServiceCocos2dx :: showFAQs (cocos2d :: ValueMap & config)
         Parameter Description:
          config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts
      5) set the game name information, call setName method (It is recommended to call this method after calling init)       
         ECServiceCocos2dx :: setName (string game_name);
         Parameter Description:
          game_name: The name of the game, which will be displayed in the title bar of the relevant interface in the SDK
      6) Set Token, use google push, call registerDeviceToken method (no)
         ECServiceCocos2dx :: registerDeviceToken (string deviceToken);
         Parameter Description:
          deviceToken: The device Token
      7) Set the user id information, call the setUserId method (using self-service must call, see 2) show a single FAQ)
         Call ECServiceCocos2dx :: setUserId (string playerUid) before showSingleFAQ;
         Parameter Description:
          playerUid: The player unique ID.
      8) Set the server number information, call setServerId method (using self-service must call, see 2) show a single FAQ)
         Call ECServiceCocos2dx :: setServerId (int serverId) before showSingleFAQ
         Parameter Description:
          serverId: Server ID.
      9) Set the player name information, call setUserName method (It is recommended to call this method after calling init)
         ECServiceCocos2dx :: setUserName (string playerName);
         Parameter Description:
          playerName: The player name.
      10) Direct vip_chat artificial customer service chat, call showConversation method (must ensure that setUserName in 9) set the
      player name information has been called)
         ECServiceCocos2dx :: showConversation (string playerUid, int serverId, cocos2d :: ValueMap & config);
         Parameter Description:
          playerUid: The player's unique id in the game
          serverId: The server ID of the player.
          config: Optional, custom ValueMap information. Refer to 1) intelligent customer service main interface starts
