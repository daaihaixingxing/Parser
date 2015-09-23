//
//  SAXViewController.m
//  Lesson15Parser
//
//  Created by lanouhn on 15/9/22.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "SAXViewController.h"
#import "Person.h"

@interface SAXViewController () <NSXMLParserDelegate>
@property (nonatomic,retain) Person *per;
@property (nonatomic,retain) NSString *str;
@property (nonatomic,retain) NSMutableArray *dataSource;

- (IBAction)handleSAXParser:(id)sender;


@end

@implementation SAXViewController

- (void)dealloc {
    self.per = nil;
    self.str = nil;
    self.dataSource = nil;
    [super dealloc];
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
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

#pragma mark ------ SAX Parser ----------
//SAX解析
- (IBAction)handleSAXParser:(id)sender {
    //解析之前 清空数据源 
    [self.dataSource removeAllObjects];
    //1. 获取本地文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    //2. 创建解析工具对象
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    //3. 设置代理
    parser.delegate = self;
    //4. 开始解析
    [parser parse];
    //5. 释放所有权
    [parser release];
}


#pragma mark ---------- NSXMLParserDelegate --------
//当读到开始标签时 <lanou39>
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"%@",elementName);
    if ([elementName isEqualToString:@"student"]) {
        //当读到student开始标签时，创建Person的对象
        self.per = [[Person alloc] init];
        _per.position = attributeDict[@"position"];
        NSLog(@"%@",_per.position);
    }
}

//当读到结束标签时 </lanou39>
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //当读到结束标签name/gender/hobby/age
    if ([elementName isEqualToString:@"name"]) {
        self.per.name = self.str;//name
    } else if ([elementName isEqualToString:@"gender"]) {
        self.per.gender = self.str;//gender
    } else if ([elementName isEqualToString:@"hobby"]) {
        self.per.hobby = self.str;//hobby
    } else if ([elementName isEqualToString:@"age"]){
        self.per.age = self.str;//age
    } else if ([elementName isEqualToString:@"student"]) {
        [self.dataSource addObject:self.per];
    }
    
}

//当解析结束时
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"%@",self.dataSource);
    [self.tableView reloadData];//刷新数据
}

//当读到标签内容时
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.str = string;//存储对应的标签内容
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
    self.per = self.dataSource[indexPath.section];
    cell.textLabel.text = self.per.name;
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
