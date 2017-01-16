//
//  ECServiceCocos2dx.m
//  SanguoCOK
//
//  Created by zhangwei on 16/4/12.
//
//

#import "ECServiceCocos2dx.h"
#import <ElvaChatServiceSDK/ECServiceSdk.h>

static NSString* elvaParseCString(const char *cstring) {
    if (cstring == NULL) {
        return NULL;
    }
    NSString * nsstring = [[NSString alloc] initWithBytes:cstring
                                                   length:strlen(cstring)
                                                 encoding:NSUTF8StringEncoding];
    return [nsstring autorelease];
}

static void elvaAddCCObjectToNSArray(cocos2d::CCObject *object, NSMutableArray *array){
    if(object == NULL) {
        return;
    }
    
    if (cocos2d::CCString *ccString = dynamic_cast<cocos2d::CCString *>(object)) {
        NSString *strElement = [NSString stringWithCString:ccString->getCString() encoding:NSUTF8StringEncoding];
        [array addObject:strElement];
    } else if (cocos2d::CCArray *ccArray = dynamic_cast<cocos2d::CCArray *>(object)) {
        NSMutableArray *arrElement = [NSMutableArray array];
        cocos2d::CCObject *element = NULL;
        for(cocos2d::CCObject** arr = (ccArray)->data->arr, **end = (ccArray)->data->arr + (ccArray)->data->num-1;
            arr <= end && (((element) = *arr) != NULL);
            arr++) {
            elvaAddCCObjectToNSArray(element, arrElement);
        }
        [array addObject:arrElement];
    }
}

static void elvaAddCCObjectToNSDict(const char * key, cocos2d::CCObject* object, NSMutableDictionary *dict)
{
    if(key == NULL || object == NULL) {
        return;
    }
    NSString *keyStr = [NSString stringWithCString:key encoding:NSUTF8StringEncoding];
    
    if (cocos2d::CCDictionary *ccDict = dynamic_cast<cocos2d::CCDictionary *>(object)) {
        NSMutableDictionary *dictElement = [NSMutableDictionary dictionary];
#if ((COCOS2D_VERSION & 0x00FF0000) > 0x20000)
        cocos2d::DictElement *element = NULL;
#else
        cocos2d::CCDictElement *element = NULL;
#endif
        cocos2d::CCDICT_FOREACH(ccDict, element)
        {
            elvaAddCCObjectToNSDict(element->getStrKey(), element->getObject(), dictElement);
        }
        [dict setObject:dictElement forKey:keyStr];
    } else if (cocos2d::CCString *element = dynamic_cast<cocos2d::CCString *>(object)) {
        NSString *strElement = [NSString stringWithCString:element->getCString() encoding:NSUTF8StringEncoding];
        [dict setObject:strElement forKey:keyStr];
    } else if (cocos2d::CCArray *ccArray = dynamic_cast<cocos2d::CCArray *>(object)) {
        NSMutableArray *arrElement = [NSMutableArray array];
        cocos2d::CCObject *element = NULL;
        if ((ccArray) && (ccArray)->data->num > 0) {
            for(cocos2d::CCObject** arr = (ccArray)->data->arr, **end = (ccArray)->data->arr + (ccArray)->data->num-1;
                arr <= end && (((element) = *arr) != NULL);
                arr++) {
                elvaAddCCObjectToNSArray(element, arrElement);
            }
        }
        [dict setObject:arrElement forKey:keyStr];
    }
}


static NSMutableDictionary* elvaParseConfigDic(cocos2d::CCDictionary *config){
    if(config == NULL){
        return nil;
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
#if ((COCOS2D_VERSION & 0x00FF0000) > 0x20000)
    cocos2d::DictElement *element = NULL;
#else
    cocos2d::CCDictElement *element = NULL;
#endif
    cocos2d::CCDICT_FOREACH(config, element)
    {
        elvaAddCCObjectToNSDict(element->getStrKey(), element->getObject(), dictionary);
    }
    return dictionary;
}

#pragma mark - 初始化init
void ECServiceCocos2dx::init(string appSecret,string domain,string appId) {
    NSString* NSAppId = elvaParseCString(appId.c_str());
    NSString* NSAppSecret = elvaParseCString(appSecret.c_str());
    NSString* NSDomain = elvaParseCString(domain.c_str());
    [ECServiceSdk init:NSAppSecret Domain:NSDomain AppId:NSAppId];
}
#pragma mark - show 不带参数config
void ECServiceCocos2dx::showElva(string playerName,string playerUid,int serverId,string playerParseId,string playershowConversationFlag){
    NSString* NSuserName = elvaParseCString(playerName.c_str());
    
    NSString* NSuserId = elvaParseCString(playerUid.c_str());
    
    NSString* parseId = elvaParseCString(playerParseId.c_str());
    
    NSString *conversationFlag =elvaParseCString(playershowConversationFlag.c_str());
    
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showElva:NSuserName PlayerUid:NSuserId ServerId:serverIdStr PlayerParseId:parseId PlayershowConversationFlag:conversationFlag];
    
    
}

#pragma mark - show 带参数config
void ECServiceCocos2dx::showElva(string playerName,string playerUid,int serverId,string playerParseId,string playershowConversationFlag,cocos2d::CCDictionary* config) {
    
    NSString* NSuserName = elvaParseCString(playerName.c_str());
    
    NSString* NSuserId = elvaParseCString(playerUid.c_str());
    
    NSString* parseId = elvaParseCString(playerParseId.c_str());
    
    NSString *conversationFlag =elvaParseCString(playershowConversationFlag.c_str());
    
    
    NSMutableDictionary *customData = elvaParseConfigDic(config);
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showElva:NSuserName PlayerUid:NSuserId ServerId:serverIdStr PlayerParseId:parseId PlayershowConversationFlag:conversationFlag Config :customData];
}



#pragma mark - faq参数为faqID
void ECServiceCocos2dx::showSingleFAQ(string faqId) {
    NSString *faqid = elvaParseCString(faqId.c_str());
    [ECServiceSdk showSingleFAQ:faqid];
}

#pragma mark - faq参数为faqID 带config
void ECServiceCocos2dx::showSingleFAQ(string faqId,cocos2d::CCDictionary* config) {
    NSString *faqid = elvaParseCString(faqId.c_str());
    NSMutableDictionary *customData = elvaParseConfigDic(config);
    [ECServiceSdk showSingleFAQ:faqid Config:customData];
    
}

#pragma mark - showFAQSection
void ECServiceCocos2dx::showFAQSection(string sectionPublishId){
    NSString *sectionId = elvaParseCString(sectionPublishId.c_str());
    [ECServiceSdk showFAQSection:sectionId];
}

#pragma mark - showFAQSection(带config)
void ECServiceCocos2dx::showFAQSection(string sectionPublishId,cocos2d::CCDictionary* config){
    NSString *sectionId = elvaParseCString(sectionPublishId.c_str());
    NSMutableDictionary *customData = elvaParseConfigDic(config);
    [ECServiceSdk showFAQSection:sectionId Config:customData];
}


#pragma mark - faqList无参数
void ECServiceCocos2dx::showFAQs() {
    [ECServiceSdk showFAQs];
}

#pragma mark - showFAQList 带参数config
void ECServiceCocos2dx::showFAQs(cocos2d::CCDictionary* config) {
    NSMutableDictionary *customData = elvaParseConfigDic(config);
    [ECServiceSdk showFAQs:customData];
}

#pragma mark - 设置游戏名称
void ECServiceCocos2dx::setName(string game_name){
    NSString* gameName  = elvaParseCString(game_name.c_str());
    [ECServiceSdk setName:gameName];
    
}

#pragma mark - 设置deviceToken
void ECServiceCocos2dx::registerDeviceToken(string deviceToken) {
    NSString* token = elvaParseCString(deviceToken.c_str());
    [ECServiceSdk registerDeviceToken:token];
    
}
#pragma mark - 设置UserId
void ECServiceCocos2dx::setUserId(string playerUid){
    NSString* userId = elvaParseCString(playerUid.c_str());
    [ECServiceSdk setUserId:userId];
}
#pragma mark - 设置ServerId
void ECServiceCocos2dx::setServerId(int serverId){
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk setServerId:serverIdStr];
}

#pragma mark - 设置userName
void ECServiceCocos2dx::setUserName(string playerName){
    NSString* userName = elvaParseCString(playerName.c_str());
    [ECServiceSdk setUserName:userName];
}
#pragma mark - 设置showConversation
void ECServiceCocos2dx::showConversation(string playerUid,int serverId){
    NSString* userId = elvaParseCString(playerUid.c_str());
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showConversation:userId ServerId:serverIdStr];
}
#pragma mark - 设置showConversation带config
void ECServiceCocos2dx::showConversation(string playerUid,int serverId,cocos2d::CCDictionary* config){
    NSString* userId = elvaParseCString(playerUid.c_str());
    NSMutableDictionary *customData = elvaParseConfigDic(config);
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showConversation:userId ServerId:serverIdStr Config:customData];
    
}
bool ECServiceCocos2dx::setSDKLanguage(const char *locale) {
    if(locale == NULL || strlen(locale) == 0) {
        return false;
    }
    NSString* language = elvaParseCString(locale);
    return [ECServiceSdk setSDKLanguage:language];
}
void ECServiceCocos2dx::useDevice() {
    [ECServiceSdk setUseDevice];
}
void ECServiceCocos2dx::setEvaluateStar(int star){
    [ECServiceSdk setEvaluateStar:star];
}
