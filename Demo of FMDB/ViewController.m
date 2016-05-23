//
//  ViewController.m
//  Demo of FMDB
//
//  Created by Sagar Shirbhate on 30/05/14.
//  Copyright (c) 2014 com.deviseapps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createDatabase];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createDatabase{
    
    //FOR CREATING OR LOADING FILE
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docsPath = [paths objectAtIndex:0];
    NSString * path = [docsPath stringByAppendingPathComponent:@"Database.sqlite"];
    database = [FMDatabase databaseWithPath:path];
    [database open];
    
    
    //FOR CREATION OF TABLE
    BOOL y=[database executeUpdate:@"CREATE TABLE PROPERTIES ( PROPERTY_ID INTEGER PRIMARY KEY,PROPERTY_NAME TEXT NOT NULL);"];
    
    //FOR INSERTING
    [database executeUpdate:@"INSERT INTO PROPERTIES ( PROPERTY_ID,PROPERTY_NAME) VALUES( '1','First Name NAME')"];//directly for passing static values.
    
    
    
    //FOR UPDATING
    NSString *str=@"1";
    NSString *query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO PROPERTIES ( PROPERTY_ID,PROPERTY_NAME) VALUES( ?,'First Name NAME')"];
    BOOL z= [database executeUpdate:query,str];
    
    //FOR WHERE CONDITION
    //FMResultSet * results = [database executeQuery:@"SELECT * FROM TEST WHERE TEST_ID=?",testNo];
    
    
    //FOR RETRIVING DATA
    FMResultSet * results = [database executeQuery:@"SELECT * FROM PROPERTIES"];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];//IN THAT ARRAY RESULT IS STORED
    int f =0;
    while ([results next]){
        [dataArray insertObject:[results resultDictionary] atIndex:f];
        f++;
    }
    NSLog(@"a  : %@",dataArray);
    if ([database hadError]) {
        NSLog(@"DB Error %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }

    NSString * STR1=[NSString stringWithFormat:@"%@",[dataArray valueForKey:@"PROPERTY_NAME"]];//SET VALUE OF RESULT
    
    //TO REMOVE /N " " _ CALL THIS METHOD
    
    STR1=[self stringByTrimmingCharactersInSet:STR1];
    
    
    //FOR DELETE THE ROW..
    BOOL T= [database executeUpdate:@"DELETE FROM PROPERTIES WHERE PROPERTY_NAME = ?",STR1];
    
    [database commit];///FOR SAVING THE DATA FINAL STAGE NO UNDO
    [database close];//FOR CLOSING THE DATABASE
}

-(NSString *)stringByTrimmingCharactersInSet:(id)_pass{
    NSString *str=[NSString stringWithFormat:@"%@",_pass];
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()  \n\""];
    str = [str stringByTrimmingCharactersInSet:charsToTrim];
    return str;
}

@end
