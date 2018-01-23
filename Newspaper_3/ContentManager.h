//
//  ContentManager.h
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemModel.h"

@interface ContentManager : NSObject <NSXMLParserDelegate>
{
    NSString *currentElement;
    ItemModel *currentItem;
    NSMutableString *contents;
    NSMutableArray *dataList;
}

+(ContentManager *)shareManager;
-(void)getRssFeedsWithUrlString:(NSString *)urlString completion:(void(^)(BOOL success, NSArray *feeds, NSString *errorMessage))callBack;



@end
