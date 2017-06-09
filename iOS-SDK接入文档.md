# 重点提醒：<br />
1.一定要进行初始化init操作，不然会无法进入Elva AI系统。<br />
2.iOS10需要获取权限，具体方法参考下面链接 http://blog.csdn.net/u012681458/article/details/51865435 <br />
3.<div>
    <table border="0">
      <tr>
        <th>方法</th>
        <th>showElva</th>
        <th>showConversation</th>
        <th>showFAQs</th>
        <th>showFAQSection</th>
        <th>showSingleFAQ</th>
      </tr>
      <tr>
        <td>作用</td>
        <td>启动机器人界面</td>
        <td>调用人工客服入口</td>
        <td>展示FAQ列表</td>
        <td>展示Section</td>
        <td>展示单条FAQ</td>
      </tr>
    </table>
</div>

# IOS SDK 接入说明：<br />
## 一、下载IOS SDK <br />
点击上一个页面右上角的“Clone or download”按钮下载IOS SDK，下载完成后解压文件。<br />
## 二、cocos2dx接口清单 <br />
把interface文件夹下的ECServiceCocos2dx.h、ECServiceCocos2dx.mm放入您的Classes文件夹。<br />
## 三、导入ElvaChatService <br />
导入ElvaChatService的文件到项目中。<br />      
## 四、接入工程配置 <br />
1、Build Settings里面Other Linker Flags 设置值-ObjC，否则会出现：unrecognized selector sent to instance exception<br/>
## 五、接口调用说明
### 1、SDK初始化（必须在游戏开始阶段调用）<br />
在Cocos2dx中调用：ECServiceCocos2dx::init(string appKey,string domain,string appId)<br />
* 其中：<br />
appKey:app密钥，从Web管理系统获取。<br />
domain:app域名，从Web管理系统获取。<br />
appId:app唯一标识，从Web管理系统获取。<br />
注：后面这三个参数，请登录 [Elva AI 后台](https://aihelp.net/elva)，在Settings菜单Applications页面查看。初次使用，请先登录[Elva AI 官网](http://aihelp.net/index.html)自助注册。<br />

### 2、接口调用方法<br />
1) 智能客服主界面启动，调用`showElva`方法，启动机器人界面<br />
ECServiceCocos2dx:: showElva (string playerName , string playerUid , int serverId,string playerParseId, string showConversationFlag,cocos2d::ValueMap& config);
> * 参数说明:<br />
playerName: 游戏中玩家名称。<br />
playerUid:玩家在游戏里的唯一标示id。<br />
serverId:玩家所在的服务器编号。<br />
playerParseId:传空。<br />
showConversationFlag(0或1):是否为vip, "0"表示:非VIP；"1"表示:VIP。此处为1时，将在机器人的聊天界面右上角，提供人工聊天的入口功能。<br />
config : (可选)自定义ValueMap信息。可以在此处设置特定的Tag信息。<br />
![showElva](https://github.com/CS30-NET/Pictures/blob/master/showElva-CN-IOS.jpg "showElva")

 > * 参数示例:<br />
    <pre>ECServiceCocos2dx:: showElva ("elvaTestName","12349303258",1,"","1",
      { 
        hs-custom-metadata＝｛
        hs-tags＝'军队，充值' 
        // (说明：hs-tags对应的值为vector类型，此处传入自定义的Tag，需要在Web管理配置同名称的Tag才能生效。)
        VersionCode＝'3'
        ｝
      }
    );
    </pre>
2) 展示单条FAQ，调用`showSingleFAQ`方法<br />
ECServiceCocos2dx:: showSingleFAQ (string faqId,cocos2d::ValueMap& config);
> * 参数说明：<br />
faqId：FAQ的PublishID,可以在[Elva AI 后台](https://aihelp.net/elva)中，从FAQ菜单下找到指定FAQ，查看PublishID。<br />
config : (可选)自定义ValueMap信息。可以在此处设置特定的Tag信息。<br />
注：如果在智能客服后台配置了FAQ的SelfServiceInterface，并且SDK配置了相关参数，将在显示FAQ的同时，右上角提供功能菜单，可以对相关的自助服务进行调用。<br />
![showSingleFAQ](https://github.com/CS30-NET/Pictures/blob/master/showSingleFAQ-CN-IOS.png "showSingleFAQ")
> 
3) 展示相关部分FAQ，调用`showFAQSection`方法<br />
ECServiceCocos2dx:: showFAQSection (string sectionPublishId,cocos2d::ValueMap& config);
> * 参数说明：<br />
sectionPublishId：FAQ Section的PublishID（可以在[Elva AI 后台](https://aihelp.net/elva) 中，从FAQs菜单下[Section]菜单，查看PublishID）。<br />
config :（可选）自定义ValueMap信息。可以在此处设置特定的Tag信息。<br />
![showFAQSection](https://github.com/CS30-NET/Pictures/blob/master/showFAQSection-CN-IOS.jpg "showFAQSection")
> 
4) 展示FAQ列表，调用`showFAQs`方法<br />
ECServiceCocos2dx:: showFAQs (cocos2d::ValueMap& config)<br />
> * 参数说明：<br />
config : (可选)自定义ValueMap信息。可以在此处设置特定的Tag信息和是否提供人工聊天的入口功能。<br />
![showFAQs](https://github.com/CS30-NET/Pictures/blob/master/showFAQs-CN-IOS.jpg "showFAQs")
> 
5) 设置游戏名称信息，调用`setName`方法(建议游戏刚进入，调用Init之后就默认调用)<br />
ECServiceCocos2dx:: setName (string game_name);
> * 参数说明:<br />
game_name：游戏名称，设置后将显示在SDK中相关界面标题栏。
> 
6) 设置Token，使用google推送，调用`registerDeviceToken`方法（暂无）<br />
ECServiceCocos2dx:: registerDeviceToken(string deviceToken);
> * 参数说明:<br />
deviceToken：设备Token。
> 
7) 设置用户id信息，调用`setUserId`方法(使用自助服务必须调用，参见 2)展示单条FAQ)<br />
在showSingleFAQ之前调用：ECServiceCocos2dx:: setUserId(string playerUid);
> * 参数说明:<br />
playerUid：玩家唯一ID。
> 
8) 设置服务器编号信息，调用`setServerId`方法(使用自助服务必须调用，参见 2)展示单条FAQ)<br />
在showSingleFAQ之前调用：ECServiceCocos2dx:: setServerId (int serverId);
> * 参数说明:<br />
serverId:服务器ID。
> 
9) 设置玩家名称信息，调用`setUserName`方法(建议游戏刚进入，调用Init之后就默认调用)<br />
ECServiceCocos2dx:: setUserName (string playerName);
> * 参数说明:<br />
playerName:玩家名称。
> 
10) 直接进行vip_chat人工客服聊天，调用`showConversation`方法(必须确保9）设置玩家名称信息setUserName 已经调用)<br />
ECServiceCocos2dx:: showConversation (string playerUid,int serverId,cocos2d::ValueMap& config);
> * 参数说明:<br />
playerUid:玩家在游戏里的唯一标示id。<br />
serverId:玩家所在的服务器编号。<br />
config : 可选，自定义ValueMap信息。参照 1)智能客服主界面启动。<br />
![showConversation](https://github.com/CS30-NET/Pictures/blob/master/showConversation-CN-IOS.png "showConversation")
11) 智能客服主界面启动，调用`showElvaOP`方法，启动 运营模块界面<br />
ECServiceCocos2dx:: showElvaOP (string playerName , string playerUid , int serverId,string playerParseId, string showConversationFlag,cocos2d::ValueMap& config);
> * 参数说明:<br />
playerName: 游戏中玩家名称。<br />
playerUid:玩家在游戏里的唯一标示id。<br />
serverId:玩家所在的服务器编号。<br />
playerParseId:传空。<br />
showConversationFlag(0或1):是否为vip, "0"表示:非VIP；"1"表示:VIP。此处为1时，将在机器人的聊天界面右上角，提供人工聊天的入口功能。<br />
config : (可选)自定义ValueMap信息。可以在此处设置特定的Tag信息。<br />
![showElva](https://github.com/CS30-NET/Pictures/blob/master/showElva-CN-IOS.jpg "showElva")

 > * 参数示例:<br />
    <pre>ECServiceCocos2dx:: showElvaOP ("elvaTestName","12349303258",1,"","1",
      { 
        hs-custom-metadata＝｛
        hs-tags＝'军队，充值' 
        // (说明：hs-tags对应的值为vector类型，此处传入自定义的Tag，需要在Web管理配置同名称的Tag才能生效。)
        VersionCode＝'3'
        ｝
      }
    );
    </pre>
