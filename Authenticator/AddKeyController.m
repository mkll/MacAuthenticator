//
//  AddKeyController.m
//  Authenticator
//
//  Created by Nico Schlumprecht on 5/25/15.
//  Copyright (c) 2015 nicos. All rights reserved.
//

#import "AddKeyController.h"

@implementation AddKeyController

-(void)awakeFromNib{
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    NSString *clipboard = [pb stringForType:NSPasteboardTypeString];
    if(clipboard != nil){
        [keyBox setStringValue:clipboard];
    }
    
    [keyBox setDelegate:self];
    [nameBox setDelegate:self];
    
}

- (IBAction) addKeyButtonPressed:(id)sender{
    NSDictionary *userInfo = @{ @"name" : [nameBox stringValue], @"secret" : [keyBox stringValue]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KeyAddedNotification" object:nil userInfo:userInfo];
    [self.window close];
}

- (IBAction)cancelButtonPressed:(id)sender{
    [self.window close];
}

-(void)controlTextDidEndEditing:(NSNotification *)notification {
    
    int action = [[[notification userInfo] objectForKey:@"NSTextMovement"] intValue];
    
    if ( action == NSReturnTextMovement )
    {
        [self addKeyButtonPressed:self];
    }
}

@end
