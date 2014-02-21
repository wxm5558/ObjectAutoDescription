//
//  NSObject+AutoDescription.m
//  Jule
//
//  Created by xxx on 14-2-21.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import "NSObject+AutoDescription.h"
#import <objc/runtime.h>


@implementation NSObject (AutoDescription)

- (NSString *) autoDescriptionForClassType:(Class)classType
{
	NSMutableString* result = [NSMutableString string];
	[result appendString:@"\n"];
	Class superClass = class_getSuperclass(classType);
	if(superClass != nil && ![superClass isEqual:[NSObject class]])
	{
		[result appendString:[self autoDescriptionForClassType:superClass]];
	}

	unsigned int property_count;
    objc_property_t * property_list = class_copyPropertyList(classType, &property_count);
	for (int i = (int)property_count - 1; i >= 0; --i)
	{
        objc_property_t property = property_list[i];
        const char * property_name = property_getName(property);
        NSString * propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];
        if (propertyName)
		{
			[result appendFormat:@"property name = %@\n", propertyName];
        }
    }
	free(property_list);

	unsigned int ivar_count;
	Ivar * ivarList= class_copyIvarList(classType, &ivar_count);
	for (int i = 0; i < ivar_count ; i++)
	{
		const char* ivarName = ivar_getName(ivarList[i]);
		NSString*ivarNameStr = [NSString  stringWithCString:ivarName encoding:NSUTF8StringEncoding];
		[result appendFormat:@"ivar name = %@\n", ivarNameStr];
	}
	free(ivarList);
	
	return result;
}

- (NSString*)autoDescription
{
	return [NSString stringWithFormat:@"[%@ {%@}]", NSStringFromClass([self class]),
			[self autoDescriptionForClassType:[self class]]];
}

@end
