//
//  AsncImageView.h
//  AsyncImage
//
//  Created by Jeffry Anthony on 1/27/11.
//  Copyright 2011 Phase Solusindo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AsyncImageView : UIImageView  {
	NSMutableData *responsedata;
	UIActivityIndicatorView *loadingAnimation;
	NSString* url;
	NSInteger bookId;
}
@property (readwrite,assign) NSMutableData *responsedata;
@property (readwrite,assign) NSInteger bookId;

- (id) initWithURLString:(NSString *)theUrlString;
-(void)setURLString:(NSString *)strURL;
-(void)loadImagetoImageView;
-(void)cleanObject;
@end
