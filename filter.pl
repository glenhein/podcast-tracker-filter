#!/usr/bin/perl

# This software is public domain. 2022

# Usage: cat some-rss-file.xml | filter.pl > clean-rss-file.xml
# Description: This script is meant to rewrite podcast enclosure urls in
# order to remove calls to trackers. The expected use-case is to use it
# as a filter for podcast feeds in liferea.

use strict;
use warnings;

while(<>) {
  my $rss = $_;

  my $matched = 0;

  # Since trackers may be chained, we keep looping through all of the known 
  # trackers until no more matches are made.

  do{
    $matched = 0;

    if($rss =~ /"https:\/\/pdcn\.co\/e\/https:\/\//) {
      $rss =~ s/"https:\/\/pdcn\.co\/e\/https:\/\//"https:\/\//g;
      $matched = 1;
    } 
    
    if($rss =~ /"https:\/\/pdcn\.co\/e\//) {
      $rss =~ s/"https:\/\/pdcn\.co\/e\//"https:\/\//g;
      $matched = 1;
    } 

    if($rss =~ /"https:\/\/www\.podtrac\.com\/pts\/redirect\.mp3\//) {
      $rss =~ s/"https:\/\/www\.podtrac\.com\/pts\/redirect\.mp3\//"https:\/\//g;
      $matched = 1;
    }

    if($rss =~ /"https:\/\/dts\.podtrac\.com\/redirect\.mp3\//) {
      $rss =~ s/"https:\/\/dts\.podtrac\.com\/redirect.mp3\//"https:\/\//g;
      $matched = 1;
    }

    if($rss =~ /"https:\/\/chrt\.fm\/track\/[0-9A-Z]+\//) {
      $rss =~ s/"https:\/\/chrt\.fm\/track\/[0-9A-Z]+\//"https:\/\//g;
      $matched = 1;
    }

    if($rss =~ /"https:\/\/chtbl\.com\/track\/[A-Z0-9]+\//) {
      $rss =~ s/"https:\/\/chtbl\.com\/track\/[A-Z0-9]+\//"https:\/\//g;
      $matched = 1;
    }

    if($rss =~ /"https:\/\/pdst\.fm\/e\//) {
      $rss =~ s/"https:\/\/pdst\.fm\/e\//"https:\/\//g;
      $matched = 1;
    }

    # This was an unusual case where the remainder of the url contained 
    # escaped characters. Liferea would not play the mp3 unless the 
    # escaped characters were converted back to unescaped characters.
    if($rss =~ /"https:\/\/anchor\.fm\/s\/[a-z0-9]+\/podcast\/play\/[0-9]+\/https/) {
      $rss =~ s/"https:\/\/anchor\.fm\/s\/[a-z0-9]+\/podcast\/play\/[0-9]+\/https/"https/g;
      $rss =~ s/%3A/:/g;
      $rss =~ s/%2F/\//g;
      $matched = 1;
    } 
   
    if($rss =~ /"https:\/\/anchor\.fm\/s\/[a-z0-9]+\/podcast\/play\/[0-9]+\//) {
      $rss =~ s/"https:\/\/anchor\.fm\/s\/[a-z0-9]+\/podcast\/play\/[0-9]+\//"https:\/\//g;
      $matched = 1;
    } 

    if($rss =~ /"https:\/\/mgln\.ai\/track\//) {
      $rss =~ s/"https:\/\/mgln\.ai\/track\//"https:\/\//g;
      $matched = 1;
    }

  } while($matched);

  print "$rss";

}
