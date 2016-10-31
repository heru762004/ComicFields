//
//  AboutController.h
//  ComicFields
//
//  Created by cynthia linarco on 3/5/11.
//  Copyright 2011 Albert Januar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AboutController : UIViewController <UIWebViewDelegate>{
	UITextView *txtView;
	UIWebView *webView;
	CGRect mainFrame;
}

@property (nonatomic, retain) UITextView *txtView;
@property (nonatomic, retain) UIWebView *webView;

-(void)updateInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
