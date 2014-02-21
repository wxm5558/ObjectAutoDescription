//
//  main.m
//  ObjectDescriptionLog
//
//  Created by xiaomanwang on 14-2-21.
//  Copyright (c) 2014年 xiaomanwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+AutoDescription.h"


@interface ObjectOne : NSObject
{
	@private
	NSString*testTwo;
}
@property(nonatomic,strong) NSString* testOne;
@end

@interface ObjectOne ()
{
	@private
	NSString*testFour;
}
@property(nonatomic, strong)NSString*testThree;
@end

@implementation ObjectOne

- (NSString*)description
{
	return [self autoDescription];
}

@end

@interface ObjectTwo : NSObject
@property(nonatomic,strong)ObjectOne*obj;
@end

@implementation ObjectTwo

- (NSString*)description
{
	return [self autoDescription];
}
@end

int main(int argc, const char * argv[])
{

	@autoreleasepool {
		NSLog(@"_________________________________");
	    ObjectOne *one = [ObjectOne new];
		NSLog(@"\n%@",one);
		
		NSLog(@"_________________________________");
		ObjectTwo *two = [ObjectTwo new];
		NSLog(@"\n%@",two);
		NSLog(@"_________________________________");
	}
    return 0;
}

