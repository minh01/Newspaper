//
//  ContentManager.m
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "ContentManager.h"

@implementation ContentManager

+(ContentManager *)shareManager
{
    static ContentManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ContentManager alloc]init];
    });
    return manager;
}

-(void)getRssFeedsWithUrlString:(NSString *)urlString completion:(void(^)(BOOL success, NSArray *feeds, NSString *errorMessage))callBack
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BOOL success =NO;
        NSString *errorMessage = nil;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if([httpResponse statusCode]==200)
            {
            dataList = [[NSMutableArray alloc]init];
            NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
            parser.delegate = self;
            BOOL result = [parser parse];
            if(result)
                {
                success=YES;
                errorMessage=nil;
                }
            else
                {
                success=NO;
                errorMessage=@"Error in XML parser";
                dataList=nil;
                }
            }
        else
            {
            success=NO;
            errorMessage=[NSString stringWithFormat:@"fail - reason: %@",[error localizedDescription]];
            }

        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(success, dataList, errorMessage);
        });
    }];
    [dataTask resume];
}



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    currentElement=elementName;
    if([elementName isEqualToString:KEY_ITEM])
        {
        currentItem=[[ItemModel alloc]init];
        }
    contents = [[NSMutableString alloc]init];
}

-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    if([currentElement isEqualToString:KEY_DESCRIPTION])
        {
        NSString *string = [[NSString alloc]initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        [self parseString:string];
        }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    if([currentElement isEqualToString:KEY_TITLE])
        {
        currentItem.title = string ;
        }
    else if([currentElement isEqualToString:KEY_PUB_DATE])
        {
        NSString *newStr=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [contents appendString:newStr];
        currentItem.pubdate = contents;
        }
    else if([currentElement isEqualToString:KEY_LINK])
        {
        NSString *newStr=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [contents appendString:newStr];
        currentItem.link = contents;
        }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:KEY_ITEM])
        {
        if (currentItem.descrip != nil & currentItem.pubdate !=nil) {
            [dataList addObject:currentItem];
        }


        }
}

-(void)parseString:(NSString *)string
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSString *imageString, *otherString;

    [scanner scanUpToString:@"src=\"" intoString:nil];
    [scanner scanString:@"src=\"" intoString:nil];
    [scanner scanUpToString:@"\"" intoString:&imageString];

    [scanner scanUpToString:@"</br>" intoString:nil];
    [scanner scanString:@"</br>" intoString:nil];
    [scanner scanUpToString:@"]]" intoString:&otherString];

    currentItem.descrip = otherString;
    currentItem.imgLink = imageString;
}


@end
