#!/bin/sh

nc-get 'http://textfiles.com/underconstruction' stdout | perl -e 'while (<>) { $_ =~ s/.*=(.*)>/$1/; system("nc-get http://textfiles.com/underconstruction/$_");}'
