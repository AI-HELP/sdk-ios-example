//
//  DBManager.h
//  ElvaMqttIOS
//
//  Created by wwj on 16/8/9.
//  Copyright © 2016年 wwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface ELVADBManager : NSObject
{
    NSString *databasePath;
}

+(ELVADBManager*)getSharedInstance;
-(BOOL)createDB;

-(BOOL) saveSections:(NSString*)sectionId title:(NSString*)title isValid:(NSString*)isValid;

-(BOOL) saveFaqs:(NSString*)faqId publishId:(NSString *)publishId sectionId:(NSString*)sectionId title:(NSString*)title body:(NSString *)body primerykey:(NSInteger)primerykey isValid:(NSString*)isValid;

-(NSMutableArray*) getAllSections;

-(NSMutableArray *)getFaqsBySectionId:(NSString *) sectionId;

-(NSString *) getFaqByPublishId:(NSString *)publishId;

-(NSString *) getFaqByFaqId:(NSString *)faqId;

@end
