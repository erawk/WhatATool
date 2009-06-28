#import <Foundation/Foundation.h>

void PrintPathInfo() {
    NSLog(@"Section 1: PrintPathInfo()\n");
    NSLog(@"==========================\n");

    NSString *path = @"~";
    path = [path stringByExpandingTildeInPath]; // reuse to save memory
    
    NSLog(@"My home folder is at: '%@'", path);

    // fast enumeration over array returned from pathComponents
    for (NSString *pathComponent in [path pathComponents]) { 
        NSLog(@"%@", pathComponent);
    }
    NSLog(@"\n");
} 

void PrintProcessInfo() { 
    NSLog(@"Section 2: PrintProcessInfo()\n");
    NSLog(@"=============================\n");

    NSProcessInfo *ps = [NSProcessInfo processInfo];
    NSLog(@"Process Name: '%@' Process ID: '%d'", [ps processName], [ps processIdentifier]);

    // NSString *processName = [ps processName];
    // NSUInteger processIdentifier = [ps processIdentifier];
    // NSLog(@"Process Name: '%@' Process ID: '%d'", processName, processIdentifier);

    NSLog(@"\n");
} 

void PrintBookmarkInfo() { 
    NSLog(@"Section 3: PrintBookmarkInfo()\n");
    NSLog(@"==============================\n");

    // value then key (backwards!)
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
      [NSURL URLWithString:@"http://www.stanford.edu"], @"Stanford University",
      [NSURL URLWithString:@"http://www.apple.ca"], @"Apple",
      [NSURL URLWithString:@"http://cs193p.stanford.edu"], @"CS193P",
      [NSURL URLWithString:@"http://itunes.stanford.edu"], @"Stanford on iTunes U",
      [NSURL URLWithString:@"http://stanfordshop.com"], @"Stanford Mail",
    nil];

    // loop through dictionary, printing only key / value pairs with keys
    // beginning with 'Stanford'
    for (NSString *key in [mDict keyEnumerator]) {
        if ([key hasPrefix:@"Stanford"]) {
            NSString *url = [mDict objectForKey:key];
            NSLog(@"Key: '%@', Value: '%@'", key, url);
        }
    }
    NSLog(@"\n");
} 

void PrintIntrospectionInfo(){
    NSLog(@"Section 4: PrintIntrospectionInfo()\n");
    NSLog(@"===================================\n");

    // create a bunch of objects and push them into a mutable array
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:7];
    [mArray addObject:@"STRING A WEE"];

    [mArray addObject:[NSMutableString stringWithString:@"MY MUTABLE string"]];

    [mArray addObject:[NSURL URLWithString:@"http://www.google.com"]];

    [mArray addObject:[NSDictionary dictionaryWithObjectsAndKeys: 
                       [NSURL URLWithString:@"http://www.stanford.edu"], @"Stanford University",
                       [NSURL URLWithString:@"http://www.apple.ca"], @"Apple",
                       nil]];
    [mArray addObject:[[NSProcessInfo processInfo] processName]];

    [mArray addObject:[NSProcessInfo processInfo]];

    // loop through array and do some introspection
    for (NSObject *obj in mArray) {
        NSLog(@"Class name: %@", [obj className]);
        NSLog(@"Is Member of NSString? %@", [obj isMemberOfClass:[NSString class]] ? @"YES" : @"NO");
        NSLog(@"Is Kind of NSString? %@", [obj isKindOfClass:[NSString class]] ? @"YES" : @"NO");

        BOOL respondsToLowercase = [obj respondsToSelector:@selector(lowercaseString)];
        NSLog(@"Responds to lowercaseString? %@", respondsToLowercase ? @"YES" : @"NO");
        if (respondsToLowercase) {
            NSLog(@"Lowercase version is: '%@'", [obj performSelector:@selector(lowercaseString)]);
        }
        NSLog(@"\n");
    }
    NSLog(@"\n");
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    PrintPathInfo();           // Section 1 
    PrintProcessInfo();        // Section 2 
    PrintBookmarkInfo();       // Section 3
    PrintIntrospectionInfo();  // Section 4
  
    [pool drain];
    return 0;
}
