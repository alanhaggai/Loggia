#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

eval 'use Test::Pod::Coverage 1.04';
plan(skip_all => 'Test::Pod::Coverage 1.04 required') if $@;
plan(skip_all => 'set TEST_POD to enable this test') unless $ENV{TEST_POD};

my @skip_modules = qw{
    Loggia::Schema
    Loggia::Schema::Result::Album
    Loggia::Schema::Result::Image
    Loggia::Schema::Result::User
    Loggia::Schema::Result::Role
    Loggia::Schema::Result::UserToRole

    t::Login
};

for my $module (all_modules('.')) {
    my $skip_flag = 0;

    for my $skip_module (@skip_modules) {
        if ($module eq $skip_module) {
            $skip_flag = 1;
        }
    }

    if (!$skip_flag) {
        pod_coverage_ok($module);
    }
}

done_testing();
