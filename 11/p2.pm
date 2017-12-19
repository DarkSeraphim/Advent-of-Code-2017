#!/usr/bin/perl6
use strict;

my $in = <STDIN>;
$in =~ s/\s+$//;
my @input = split /,/, $in;

sub max ($$) { $_[$_[0] < $_[1]] }
sub min ($$) { $_[$_[0] > $_[1]] }

sub distance {
    my $sr = shift;
    my %counter = %$sr;
    
    my @opposites = (['n', 's'], ['sw', 'ne'], ['nw', 'se']);
    my %merges = (s => ['sw', 'se'], 
                  n => ['nw', 'ne'], 
                  se => ['s', 'ne'], 
                  sw => ['nw', 's'],
                  nw => ['sw', 'n'],
                  ne => ['se', 'n']
                 );
    
    
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
    return $sum;
}

my $maxsum = -1;
my %counter;
foreach my $step (@input) {
    $counter{$step}++;
    $maxsum = max ((distance(\%counter)), $maxsum);
}

print "Max distance is ", $maxsum;
