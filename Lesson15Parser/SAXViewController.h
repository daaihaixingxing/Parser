//
//  SAXViewController.h
//  Lesson15Parser
//
//  Created by lanouhn on 15/9/22.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 解析：
 *  按照约定好的格式提取数据的过程
   后台开发人员按照约定好的格式存入数据，前段开发人员以约定好的格式读取数据。
 主要流行的有两种格式：
 1、JSON：
 2、XML：解析的两种工作原理
   1)、SAX解析：基于事件回调的解析机制。逐行解析，效率低。适合大数据解析。系统提供的NSXMLParser
   2)、DOM解析：把解析数据全部读入内存，初始化成树形结构，逐层进行解析，效率高。适合小数据解析。谷歌提供的GDataXMLNode
 */

@interface SAXViewController : UITableViewController
@end
