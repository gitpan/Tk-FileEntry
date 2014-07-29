### tests perl/Tks tixish FileEntry widget
###
### $Source: t/fileentry.t $ $Revision: 1.2 $

# About the tests:  Nothing realy useful up to now.

require 't/TESTsetup';

use Tk::FileEntry;
use strict;

my $parent = testarea(7);  # In: number of tests.  Out: test area to use

$| = 1;
my $verbose = 1;

my $w;
{
    print "# create FileEntry widget...\n";

    $w = $parent->FileEntry(
        #-command => sub {print "callback got |".shift()."|".shift()."|\n"},
    );
    ok(defined $w);
    ok(defined $w->pack(-fill=>'x', -side=>'top'));
    
    
    print "# option -label widget...\n";
    ok($w->cget('-label') eq 'File:');
    $w->configure(-label=>'Do with:');
    ok($w->cget('-label') eq 'Do with:');
    
    
    {
        print "# testing -variable binding ...\n";
        my $var;
        $w->configure(-variable => \$var);
        
        print "# insert works for entry subwidget...\n";
        $w->delete(0, 'end');
        $w->insert('end','foobar');
        ok('foobar' eq $var);
        
        print "# delete works for entry subwidget...\n";
        $w->delete(0, 'end');
        ok($var eq '');
        
        print "# setting variable(undef) yields no bound variable...\n";
        $w->variable(undef);
        my $bound_variable_value = $w->Subwidget('entry')->cget('-textvariable');
        ok(not defined $bound_variable_value);
    }
}

testend();

__END__
