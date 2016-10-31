//
//  AboutController.m
//  ComicFields
//
//  Created by cynthia linarco on 3/5/11.
//  Copyright 2011 Albert Januar. All rights reserved.
//

#import "AboutController.h"

@implementation AboutController
@synthesize txtView, webView;

-(id) init
{
	if ((self = [super init])) {
		self.title = @"About";
		txtView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		txtView.dataDetectorTypes = UIDataDetectorTypeAll;
		[txtView setFont:[UIFont boldSystemFontOfSize:18.0]];
		[txtView setTextAlignment:UITextAlignmentCenter];
		[txtView setEditable:FALSE];
		[txtView setText:@"Version 1.0 Comics Field\n\nhttp://www.comicsfield.com"];
		
		UINavigationBar *nv = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 440)];
		[self.view addSubview:nv];
		
		webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		NSString *address = [NSString stringWithFormat:@"http://www.comicsfield.com"];
		NSURL *url = [NSURL URLWithString:address];
		NSURLRequest *req = [NSURLRequest requestWithURL:url];
		
		[webView loadRequest:req];
		
		[self.view addSubview:webView];
		//[self.view addSubview:txtView];
		
		[webView release];
		[txtView release];
		[nv release];
	}
	
	return self;
}

-(void) loadView 
{
	[super loadView];
}

-(void) viewDidLoad
{
	[super viewDidLoad];
}

-(void)updateInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		mainFrame = CGRectMake(0.0, 0.0, 320.0, 480.0);
	} else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
		mainFrame = CGRectMake(0.0, 0.0, 480.0, 320.0);
	}
	txtView.frame = CGRectMake(0.0, 0.0, mainFrame.size.width, mainFrame.size.height);
	webView.frame = mainFrame;
}


- (void)dealloc {
    [super dealloc];
}

@end
