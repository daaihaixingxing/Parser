//
//  JSONViewController.m
//  Lesson15Parser
//
//  Created by lanouhn on 15/9/22.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "JSONViewController.h"
#import "JSONKit.h"
#import "Person.h"

@interface JSONViewController ()

@property (nonatomic,retain) NSMutableArray *dataSource;

@end

@implementation JSONViewController

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

#pragma mark ------ handle Parser -----
//系统方法解析
- (IBAction)handleSystemJSONParser:(id)sender {
    [self.dataSource removeAllObjects];
    //将json格式的数据转化为OC对象
    //1. 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Person" ofType:@"json"];
    //2. 根据路径转化为NSData对象
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //3. 解析
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@",arr);
    for (NSDictionary *dic in arr) {
        Person *per = [[Person alloc] init];
        per.name = dic[@"name"];
        per.gender = dic[@"gender"];
        per.age = dic[@"age"];
        per.job = dic[@"job"];
        [self.dataSource addObject:per];
    }
    [self.tableView reloadData];
}
//第三方方法解析
- (IBAction)handleThirdpartJSONParser:(id)sender {
    //JSONKit 通过给NSString、NSData添加分类的方式，增加解析功能
    [self.dataSource removeAllObjects];
    //将json格式的数据转化为OC对象
    //1. 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Person" ofType:@"json"];
    /*
    //2. *********第一种方式：根据文件路径初始化为字符串对象
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //3. 解析成OC对象
    NSArray *arr = [jsonStr objectFromJSONString];
    NSLog(@"%@",arr);
     */
    
    //********* 第二种方式：
    //2. 根据文件路径初始化为NSData对象
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    //3. 解析 (可变/bukebian)
    NSArray *arr = [jsonData objectFromJSONData];
//    NSMutableArray *arr = [jsonData mutableObjectFromJSONData];
    NSLog(@"%@",arr);
    
    for (NSDictionary *dic in arr) {
        Person *per = [[Person alloc] init];
        per.name = dic[@"name"];
        per.gender = dic[@"gender"];
        per.age = dic[@"age"];
        per.job = dic[@"job"];
        [self.dataSource addObject:per];
    }
    [self.tableView reloadData];
    
    //********************************************//
    //将OC对象转成JSON格式的数据
    //1.将数组转化为json格式数据
    NSArray *array = @[@"1",@"2",@"3"];
    [array JSONString];//转成JSON格式字符串
    NSLog(@"%@",[array JSONString]);
    [array JSONData];//转成json格式Data
    NSLog(@"%@",[array JSONData]);
    
    NSString *str = @"mmmm";
    [str JSONString];//转成JSON格式字符串
    NSLog(@"%@",[str JSONString]);
    [str JSONData];//转成JSON格式Data
    NSLog(@"%@",[str JSONData]);
    
    NSDictionary *dic = @{@"name":@"zhi",@"age":@"23"};
    [dic JSONString];//转成JSON格式字符串
    NSLog(@"%@",[dic JSONString]);
    [dic JSONData];//转成JSON格式Data
    NSLog(@"%@",[dic JSONData]);
    
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
//    cell.textLabel.text = per.name;
//    cell.detailTextLabel.text = per.age;
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:110];
    UILabel *genderLabel = (UILabel *)[cell viewWithTag:111];
    UILabel *ageLabel = (UILabel *)[cell viewWithTag:112];
    UILabel *jobLabel = (UILabel *)[cell viewWithTag:113];
    
    nameLabel.text = per.name;
    genderLabel.text = per.gender;
    ageLabel.text = per.age;
    jobLabel.text = per.job;
    
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
