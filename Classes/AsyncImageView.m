//
//  AsncImageView.m
//  AsyncImage
//
//  Created by Jeffry Anthony on 1/27/11.
//  Copyright 2011 Phase Solusindo. All rights reserved.
//

#import "AsyncImageView.h"
#import "NSStringHelper.h"

@implementation AsyncImageView
@synthesize responsedata;
@synthesize bookId;

-(id)init {
	if((self = [super init] )!= nil) {
	}
	return self;
}

- (id)initWithURLString:(NSString *)theUrlString
{
	
	if (( self = [super init] )!= nil ){
		//NSLog(@"URL STRING : %@",theUrlString);
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		loadingAnimation = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		loadingAnimation.frame = CGRectMake((198.0/2) - (40.0/2), (244.0/2) - (40.0/2) , 40, 40);
		[self addSubview:loadingAnimation];
		
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentPath = [documentPaths objectAtIndex:0];
		NSArray *pecah = [theUrlString componentsSeparatedByString:@"/"];
		NSString *path = [NSString stringWithFormat:@"%@/book/cover/%@", documentPath ,[pecah objectAtIndex:[pecah count] - 1]];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		if([fileManager fileExistsAtPath:path]) {
			[loadingAnimation removeFromSuperview];
			[loadingAnimation release];
			[self.image release], self.image = [UIImage imageWithContentsOfFile:path];
		}
		else {
			if(self.responsedata != nil) {
				[self.responsedata release];
			}
			self.responsedata = [[NSMutableData alloc] initWithCapacity:2048];
			[self.image release];//self.image = [UIImage imageNamed:@"No image.png"]; 	
			[loadingAnimation startAnimating];
			url = [[NSString alloc] initWithString: theUrlString];
			[self loadImagetoImageView];
		}
		[pool release];
	}
		
	return self;
}

-(void)setURLString:(NSString *)strURL {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	loadingAnimation = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self addSubview:loadingAnimation];
	loadingAnimation.frame = CGRectMake((100.0/2) - (40.0/2), (130.0/2) - (40.0/2) , 40, 40);
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath = [documentPaths objectAtIndex:0];
	//NSLog(@"%@", strURL);
	NSString *path = [NSString stringWithFormat:@"%@/book/cover/%d.jpg", documentPath ,bookId];
	//NSLog(@"%@", path);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:path]) {
		[loadingAnimation removeFromSuperview];
		[loadingAnimation release];
		self.image = nil; self.image = [UIImage imageWithContentsOfFile:path];
	}
	else {
		//if(self.responsedata != nil) {
			[self.responsedata release];
		//}
		self.responsedata = [[NSMutableData alloc] initWithCapacity:2048];
		self.image = nil; //self.image = [UIImage imageNamed:@"No image 2.png"]; 
		[loadingAnimation startAnimating];
		url = [[NSString alloc] initWithString: strURL];
		[self loadImagetoImageView];
	}
	[pool release];
}

-(void)loadImagetoImageView{
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		[[NSURLCache sharedURLCache] setMemoryCapacity:0];
		[[NSURLCache sharedURLCache] setDiskCapacity:0];
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
		[[NSURLConnection alloc] initWithRequest:request delegate:self];
		[pool release];
} 

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{ 
	[self.responsedata setLength:0];
} 

-(void) connection:(NSURLConnection*)connection didReceiveData:(NSData*)data{
	[self.responsedata appendData:data];
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError*)error{
	[self.responsedata release];
	[connection release];
	//CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"System" message:[[error userInfo] valueForKey:@"NSLocalizedDescription"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//	[alert show];
//	[alert release];
}

-(void) connectionDidFinishLoading:(NSURLConnection*)connection{
	//NSLog(@"finished loading %@",self.responsedata);
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath = [documentPaths objectAtIndex:0];
	NSString *path = [NSString stringWithFormat:@"%@/book/cover/%d.jpg", documentPath ,self.bookId];
	NSFileManager *fileManager = [NSFileManager defaultManager]; 
	if (![fileManager fileExistsAtPath:path]) {
		[fileManager
		 createDirectoryAtPath:[path substringWithRange:NSMakeRange(0, [NSStringHelper lastIndexOf:path withString:@"/"])]
		 withIntermediateDirectories:YES
		 attributes:nil
		 error:nil];
		[self.responsedata writeToFile:path atomically:YES];
	}
	self.image = [UIImage imageWithData:self.responsedata];
	[self.responsedata release];
	[loadingAnimation stopAnimating];
	[loadingAnimation removeFromSuperview];
	[loadingAnimation release];
	[url release];
	[connection release];
	[pool release];
}

-(void)cleanObject {
	while ([[self subviews] count] > 0) {
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
}

- (void)dealloc {
       [super dealloc];
}


@end
