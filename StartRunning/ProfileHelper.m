//
//  ProfileHelper.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 20/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "ProfileHelper.h"
#import "Person.h"
#import "PlistManager.h"

@interface ProfileHelper ()

@property(nonatomic,strong)PlistManager *plistManager;

@end

@implementation ProfileHelper

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}

-(double)calculateIMC{
	Person *person=[[Person alloc]init];
	person=[self.plistManager loadProfile];
	if (person.height==0 || person.weight==0) {
    return 0;
	}
	double imc=person.weight/(person.height*person.height);
	
	return imc;
}

//-(double)radiansWithIMC:(double)imc{
//	
//	if (imc<=28) {
//    	double alpha=1/sin((imc-16.0)/12);
//	}else{
//			double alpha=1/cos((imc-16.0)/12);
//	}
//
//}

@end
