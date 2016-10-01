#!/usr/local/bin/perl

#
# Usage: ./life_game.pl < initial_pattern.dat
#
# an example of initial_pattern.dat:
# o__o_
# __o_o
# oo___

use strict;
use warnings;
use utf8;
use Encode 'decode', 'encode';

# Define constants.
#my ($living_cell, $dead_cell) = ('👾 ', '🌫 ');
my ($living_cell, $dead_cell) = ('👻 ', '🌿 ');
#my ($living_cell, $dead_cell) = ('🎃 ', '🌃 ');
#my ($living_cell, $dead_cell) = ('🐠 ', '🌊 ');
#my ($living_cell, $dead_cell) = ('🐠 ', '  ');
my $max_generation = 50;
my $sleeping_seconds = 0.2;

my @life_pattern;
# ex.
#    0123456    <-- column indexes (0 and 6 are used for dummy data)
# 0: 0000000
# 1: 0100100
# 2: 0001010
# 3: 0110000
# 4: 0000000
# ^
# |
# row indexes (0 and 4 are used for dummy data)

# Read and set the initial pattern.
my $row_number_to_be_read_next = 0;
my $column_max_index = 0;
while (<STDIN>) {
  chomp;
  my @tmp = split(//, $_);
  # If this line is the first line of the input file,
  # then set the topmost row as a dummy row.
  if ($row_number_to_be_read_next==0) {
    $column_max_index=$#tmp+2;
    for (my $c=0; $c<=$column_max_index; $c++) {
      $life_pattern[0][$c]=0;
    }
    $row_number_to_be_read_next=1;
  }
  # If the input file is illegally formatted, then die.
  if ($column_max_index != $#tmp+2) {
    die ("$column_max_index is not equal to " . $#tmp+2);
  }
  # Set the leftmost and rightmost dummy cells of the current row.
  $life_pattern[$row_number_to_be_read_next][0]=0;
  $life_pattern[$row_number_to_be_read_next][$column_max_index]=0;
  # Set the other cells of the current row.
  for (my $i=0; $i<=$#tmp; $i++) {
    if ($tmp[$i] eq 'o') {
      $life_pattern[$row_number_to_be_read_next][$i+1]=1;
    } else {
      $life_pattern[$row_number_to_be_read_next][$i+1]=0;
    }
  }
  # Prepare for the next line.
  $row_number_to_be_read_next++;
}
# Set the bottommost row as a dummy row.
my $row_max_index=$row_number_to_be_read_next;
for (my $c=0; $c<=$column_max_index; $c++) {
  $life_pattern[$row_max_index][$c]=0;
}

# Main loop
for (my $g=0; $g<=$max_generation; $g++) {
  # Print the pattern (except for dummy cells) at the current generation.
  system('clear');
  print "### Generation: $g ###\n";
  for (my $r=1; $r<=$row_max_index-1; $r++) {
    for (my $c=1; $c<=$column_max_index-1; $c++) {
      if ($life_pattern[$r][$c]) {
        print encode('utf-8', $living_cell);
      } else {
        print encode('utf-8', $dead_cell);
      }
    }
    print "\n";
  }
  system("sleep $sleeping_seconds");

  # Save the current pattern as the old pattern.
  my @old_pattern;
  for (my $r=0; $r<=$row_max_index; $r++) {
    for (my $c=0; $c<=$column_max_index; $c++) {
      $old_pattern[$r][$c]=$life_pattern[$r][$c];
    }
  }
  # Update the pattern.  
  for (my $r=1; $r<=$row_max_index-1; $r++) {
    for (my $c=1; $c<=$column_max_index-1; $c++) {
      my $n=0; # the number of living cells around the current cell
      $n+=$old_pattern[$r-1][$c-1];
      $n+=$old_pattern[$r-1][$c];
      $n+=$old_pattern[$r-1][$c+1];
      $n+=$old_pattern[$r][$c-1];
      $n+=$old_pattern[$r][$c+1];
      $n+=$old_pattern[$r+1][$c-1];
      $n+=$old_pattern[$r+1][$c];
      $n+=$old_pattern[$r+1][$c+1];
      if ($old_pattern[$r][$c]) { # The current cell is now living.
        if ($n==2 || $n==3) {
          $life_pattern[$r][$c]=1; # This cell will live on.
        } else {
          $life_pattern[$r][$c]=0; # This cell will die.
        }
      } else { # The current cell is now dead.
        if ($n==3) {
          $life_pattern[$r][$c]=1; # A new life will be born at this cell.
        }
      }
    }
  }
}
