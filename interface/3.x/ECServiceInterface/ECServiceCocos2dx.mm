//
//  ECServiceCocos2dx.m
//
//  Created by xdl on 16/10/12.
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

static void elvaAddObjectToNSArray(const cocos2d::Value& value, NSMutableArray *array)
{
    if(value.isNull()) {
        return;
    }
    // add string into array
    if (value.getType() == cocos2d::Value::Type::STRING) {
        NSString *element = [NSString stringWithCString:value.asString().c_str() encoding:NSUTF8StringEncoding];
        [array addObject:element];
    } else if (value.getType() == cocos2d::Value::Type::FLOAT) {
        NSNumber *number = [NSNumber numberWithFloat:value.asFloat()];
        [array addObject:number];
    } else if (value.getType() == cocos2d::Value::Type::DOUBLE) {
        NSNumber *number = [NSNumber numberWithDouble:value.asDouble()];
        [array addObject:number];
    } else if (value.getType() == cocos2d::Value::Type::BOOLEAN) {
        NSNumber *element = [NSNumber numberWithBool:value.asBool()];
        [array addObject:element];
    } else if (value.getType() == cocos2d::Value::Type::INTEGER) {
        NSNumber *element = [NSNumber numberWithInt:value.asInt()];
        [array addObject:element];
    }
}

static void elvaAddObjectToNSDict(const std::string& key, const cocos2d::Value& value, NSMutableDictionary *dict)
{
    if(value.isNull() || key.empty()) {
        return;
    }
    NSString *keyStr = [NSString stringWithCString:key.c_str() encoding:NSUTF8StringEncoding];
    if (value.getType() == cocos2d::Value::Type::MAP) {
        NSMutableDictionary *dictElement = [[NSMutableDictionary alloc] init];
        cocos2d::ValueMap subDict = value.asValueMap();
        for (auto iter = subDict.begin(); iter != subDict.end(); ++iter) {
            elvaAddObjectToNSDict(iter->first, iter->second, dictElement);
        }
        [dict setObject:dictElement forKey:keyStr];
    } else if (value.getType() == cocos2d::Value::Type::FLOAT) {
        NSNumber *number = [NSNumber numberWithFloat:value.asFloat()];
        [dict setObject:number forKey:keyStr];
    } else if (value.getType() == cocos2d::Value::Type::DOUBLE) {
        NSNumber *number = [NSNumber numberWithDouble:value.asDouble()];
        [dict setObject:number forKey:keyStr];
    } else if (value.getType() == cocos2d::Value::Type::BOOLEAN) {
        NSNumber *element = [NSNumber numberWithBool:value.asBool()];
        [dict setObject:element forKey:keyStr];
    } else if (value.getType() == cocos2d::Value::Type::INTEGER) {
        NSNumber *element = [NSNumber numberWithInt:value.asInt()];
        [dict setObject:element forKey:keyStr];
    } else if (value.getType() == cocos2d::Value::Type::STRING) {
        NSString *strElement = [NSString stringWithCString:value.asString().c_str() encoding:NSUTF8StringEncoding];
        [dict setObject:strElement forKey:keyStr];
    } else if (value.getType() == cocos2d::Value::Type::VECTOR) {
        NSMutableArray *arrElement = [NSMutableArray array];
        cocos2d::ValueVector array = value.asValueVector();
        for(const auto& v : array) {
            elvaAddObjectToNSArray(v, arrElement);
        }
        [dict setObject:arrElement forKey:keyStr];
    }
}

static NSMutableDictionary * elvaValueMapToNSDictionary(cocos2d::ValueMap& dict) {
    NSMutableDictionary *nsDict = [NSMutableDictionary dictionary];
    for (auto iter = dict.begin(); iter != dict.end(); ++iter)
    {
        elvaAddObjectToNSDict(iter->first, iter->second, nsDict);
    }
    return nsDict;
}

static NSMutableDictionary* elvaParseConfig(cocos2d::ValueMap& config){
    return elvaValueMapToNSDictionary(config);
}

#pragma mark - init
void ECServiceCocos2dx::init(string appSecret,string domain,string appId) {
    NSString* NSAppId = elvaParseCString(appId.c_str());
    NSString* NSAppSecret = elvaParseCString(appSecret.c_str());
    NSString* NSDomain = elvaParseCString(domain.c_str());
    [ECServiceSdk init:NSAppSecret Domain:NSDomain AppId:NSAppId];
}
#pragma mark - showElva
void ECServiceCocos2dx::showElva(string playerName,string playerUid,int serverId,string playerParseId,string playershowConversationFlag){
    NSString* NSuserName = elvaParseCString(playerName.c_str());
    
    NSString* NSuserId = elvaParseCString(playerUid.c_str());
    
    NSString* parseId = elvaParseCString(playerParseId.c_str());
    
    NSString *conversationFlag =elvaParseCString(playershowConversationFlag.c_str());
    
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showElva:NSuserName PlayerUid:NSuserId ServerId:serverIdStr PlayerParseId:parseId PlayershowConversationFlag:conversationFlag];
    
    
}

#pragma mark - showElva has param config
void ECServiceCocos2dx::showElva(string playerName,string playerUid,int serverId,string playerParseId,string playershowConversationFlag,cocos2d::ValueMap& config) {
    
    NSString* NSuserName = elvaParseCString(playerName.c_str());
    
    NSString* NSuserId = elvaParseCString(playerUid.c_str());
    
    NSString* parseId = elvaParseCString(playerParseId.c_str());
    
    NSString *conversationFlag =elvaParseCString(playershowConversationFlag.c_str());
    
    
    NSMutableDictionary *customData = elvaParseConfig(config);
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showElva:NSuserName PlayerUid:NSuserId ServerId:serverIdStr PlayerParseId:parseId PlayershowConversationFlag:conversationFlag Config :customData];
}



#pragma mark - singleFaq
void ECServiceCocos2dx::showSingleFAQ(string faqId) {
    NSString *faqid = elvaParseCString(faqId.c_str());
    [ECServiceSdk showSingleFAQ:faqid];
}

#pragma mark - singleFaq has config
void ECServiceCocos2dx::showSingleFAQ(string faqId,cocos2d::ValueMap& config) {
    NSString *faqid = elvaParseCString(faqId.c_str());
    NSMutableDictionary *customData = elvaParseConfig(config);
    [ECServiceSdk showSingleFAQ:faqid Config:customData];
    
}

#pragma mark - showFAQSection
void ECServiceCocos2dx::showFAQSection(string sectionPublishId){
    NSString *sectionId = elvaParseCString(sectionPublishId.c_str());
    [ECServiceSdk showFAQSection:sectionId];
}

#pragma mark - showFAQSection(has config)
void ECServiceCocos2dx::showFAQSection(string sectionPublishId,cocos2d::ValueMap& config){
    NSString *sectionId = elvaParseCString(sectionPublishId.c_str());
    NSMutableDictionary *customData = elvaParseConfig(config);
    [ECServiceSdk showFAQSection:sectionId Config:customData];
}


#pragma mark - faqList no param
void ECServiceCocos2dx::showFAQs() {
    [ECServiceSdk showFAQs];
}

#pragma mark - showFAQList has param config
void ECServiceCocos2dx::showFAQs(cocos2d::ValueMap& config) {
    NSMutableDictionary *customData = elvaParseConfig(config);
    [ECServiceSdk showFAQs:customData];
}

#pragma mark - setGameName
void ECServiceCocos2dx::setName(string game_name){
    NSString* gameName  = elvaParseCString(game_name.c_str());
    [ECServiceSdk setName:gameName];
    
}

#pragma mark - setdeviceToken
void ECServiceCocos2dx::registerDeviceToken(string deviceToken) {
    NSString* token = elvaParseCString(deviceToken.c_str());
    [ECServiceSdk registerDeviceToken:token];
    
}
#pragma mark - setUserId
void ECServiceCocos2dx::setUserId(string playerUid){
    NSString* userId = elvaParseCString(playerUid.c_str());
    [ECServiceSdk setUserId:userId];
}
#pragma mark - setServerId
void ECServiceCocos2dx::setServerId(int serverId){
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk setServerId:serverIdStr];
}

#pragma mark - setuserName
void ECServiceCocos2dx::setUserName(string playerName){
    NSString* userName = elvaParseCString(playerName.c_str());
    [ECServiceSdk setUserName:userName];
}
#pragma mark - setshowConversation
void ECServiceCocos2dx::showConversation(string playerUid,int serverId){
    NSString* userId = elvaParseCString(playerUid.c_str());
    NSString* serverIdStr = [NSString stringWithFormat:@"%d",serverId];
    [ECServiceSdk showConversation:userId ServerId:serverIdStr];
}
#pragma mark - setshowConversation带config
void ECServiceCocos2dx::showConversation(string playerUid,int serverId,cocos2d::ValueMap& config){
    NSString* userId = elvaParseCString(playerUid.c_str());
    NSMutableDictionary *customData = elvaParseConfig(config);
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