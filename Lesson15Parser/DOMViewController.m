//
//  DOMViewController.m
//  Lesson15Parser
//
//  Created by lanouhn on 15/9/22.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "DOMViewController.h"
#import "GDataXMLNode.h"
#import "Person.h"

/**
 *  DOM解析:
   GDataXMLNode 有Google提供的一个开源的基于C语言的libxml2.dylib动态的链接库进行封装而成的OC的XML数据解析类。解析效率较高。
 使用时：
 1. target - Build Settings - Header Search Path 添加路径  /usr/include/libxml2
 2. target - Build Phases - LinkBinary  添加libxml2.dylib
 */
@interface DOMViewController ()

@property (nonatomic,retain) NSMutableArray *dataSource;

@end

@implementation DOMViewController

- (void)dealloc {
    self.dataSource = nil;
    [super dealloc];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark ------ DOM Parser -----
- (IBAction)handleRootParser:(id)sender {
    //解析之前 清空数据源
    [self.dataSource removeAllObjects];
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    //根据路径初始化字符串对象
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //将解析的内容写入GDataXMLDocument
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    //GDataXMLDocument 获取节点 （获取根节点）
    GDataXMLElement *rootElement = [document rootElement];
    NSArray *stuElements = [rootElement elementsForName:@"student"];
    //对数组进行遍历
    for (GDataXMLElement *element in stuElements) {
        //获取student节点下 name/gender/hobby/age
        GDataXMLElement *nameElement = [[element elementsForName:@"name"] firstObject];//只有一个name节点
        GDataXMLElement *genderElement = [[element elementsForName:@"gender"] firstObject];
        GDataXMLElement *hobbyElement = [[element elementsForName:@"hobby"] firstObject];
        GDataXMLElement *ageElement = [[element elementsForName:@"age"] firstObject];
        
        Person *per = [[Person alloc] init];
        //获取节点中的内容 为per赋值
        per.name = [nameElement stringValue];
        per.gender = [genderElement stringValue];
        per.hobby = [hobbyElement stringValue];
        per.age = [ageElement stringValue];
        
        //获取节点属性
        GDataXMLNode *node = [element attributeForName:@"position"];
        per.position = [node stringValue];//获取其中的数据
        
        //将对象存储到数据源
        [self.dataSource addObject:per];
        [per release];
        
    }
    NSLog(@"%@",_dataSource);
    //重新读取数据 刷新界面
    [self.tableView reloadData];
    
    
}

- (IBAction)handleXParser:(id)sender {
    //解析之前 清空数据源
    [self.dataSource removeAllObjects];
    //1. 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    //2. 根据路径初始化为字符串对象
    NSString *xmlStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //3. 将解析内容写入GDataXMLDocument文档中
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:xmlStr options:0 error:nil];
    //4. 获取所有的name节点
    NSArray *nameElements = [document nodesForXPath:@"//name" error:nil];
    //5. 获取所有的gender节点
    NSArray *genderElements = [document nodesForXPath:@"//gender" error:nil];
    //6. 获取所有的hobby节点
    NSArray *hobbyElements = [document nodesForXPath:@"//hobby" error:nil];
    //7. 获取所有的age节点
    NSArray *ageElements = [document nodesForXPath:@"//age" error:nil];
    
    //8. 获取所有的Student节点
    NSArray *stuElements = [document nodesForXPath:@"//student" error:nil];
    NSLog(@"%@",stuElements);
    
    for (int i = 0; i < nameElements.count;i++) {
        GDataXMLElement *nameElement = nameElements[i];
        GDataXMLElement *genderElement = genderElements[i];
        GDataXMLElement *hobbyElement = hobbyElements[i];
        GDataXMLElement *ageElement = ageElements[i];
        
        Person *per = [[Person alloc] init];
        per.name = [nameElement stringValue];
        per.gender = [genderElement stringValue];
        per.hobby = [hobbyElement stringValue];
        per.age = [ageElement stringValue];
        
        [self.dataSource addObject:per];
        [per release];
    }
    NSLog(@"%@",_dataSource);
    //刷新界面 获取最新数据
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Person *per = self.dataSource[indexPath.section];
    cell.textLabel.text = per.name;
    cell.detailTextLabel.text = per.age;
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
