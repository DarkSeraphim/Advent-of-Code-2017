#!/usr/bin/perl6
use strict;

my $in = <STDIN>;
$in =~ s/\s+$//;
my @input = split /,/, $in;

my %counter;
$counter{$_}++ foreach (@input);

my @opposites = (['n', 's'], ['sw', 'ne'], ['nw', 'se']);
my %merges = (s => ['sw', 'se'], 
              n => ['nw', 'ne'], 
              se => ['s', 'ne'], 
              sw => ['nw', 's'],
              nw => ['sw', 'n'],
              ne => ['se', 'n']
             );

sub min ($$) { $_[$_[0] > $_[1]] }

while (1) {
    my $opef = 0;
    my $meef = 0;
    for my $pair (@opposites) {
        my $a = $pair->[0];
        my $b = $pair->[1];
        my $min = min $counter{$a}, $counter{$b};
        
        if ($min > 0) {
            $counter{$a} -= $min;
            $counter{$b} -= $min;
            $opef = 1;
        }
    }
    for my $repl (keys %merges) {
        my $a = $merges{$repl}->[0];
        my $b = $merges{$repl}->[1];
        my $min = min $counter{$a}, $counter{$b};
        if ($min > 0) {
            $counter{$a} -= $min;
            $counter{$b} -= $min;
            $counter{$repl} += $min;
            $meef = 1;
        }
    }
    
    unless ($opef || $meef) {
        last;
    } 
}

my $sum = 0;
$sum += $_ for (values %counter);
print "Distance is ", $sum
