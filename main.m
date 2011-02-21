//
//  main.m
//  HelloSHRUG
//
//  Created by Peter Lind on 2/21/11.
//  Copyright Valtech AB 2011. All rights reserved.
//

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
