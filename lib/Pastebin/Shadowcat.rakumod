use HTTP::UserAgent;
use URI::Encode;
use HTML::Entity;

unit class Pastebin::Shadowcat:ver<2.002>:auth<zef:raku-community-modules>;

has $!pastebin_url = 'http://fpaste.scsys.co.uk/';

method paste($paste, $summary? --> Str:D) {
    my $res := HTTP::UserAgent.new.post: $!pastebin_url ~ 'paste', %(
        :channel(''), :nick(''), :summary($summary // ''), :paste($paste),
        'Paste it' => 'Paste it'
    );
    $res.is-success or fail $res.status-line;
    $res.content ~~ /
        'meta http-equiv="refresh" content="5;url=' $<url>=<-["]>+
    / or fail 'Did not find paste URL in response from the pastebin';
    ~$<url>
}

method fetch ($what) returns List {
    my $paste_url := $what ~~ m:P5/\D/ ?? $what !! $!pastebin_url ~ $what;

    my $res := HTTP::UserAgent.new.get: $paste_url;
    $res.is-success or fail 'Did not find that paste';
    $res.content ~~ /
        '<br>' \s+ '<b>' $<summary>=.+ '</b>' .+ '<pre>' $<paste>=.+ '</pre>'
    / or fail 'Could not find paste content on the returned page';

    decode-entities(~$<paste>), decode-entities(~$<summary>),
}

=begin pod

=head1 NAME

Pastebin::Shadowcat - Raku interface to http://fpaste.scsys.co.uk/

=head1 SYNOPSIS

=begin code :lang<raku>

use Pastebin::Shadowcat;

my $p = Pastebin::Shadowcat.new;
say "Pasting test content:";
my $paste_url = $p.paste('<pre>test paste1</pre>', 'My optional summary');
say "Paste is located at $paste_url";

say "Retrieiving paste content:";
my ( $content, $summary ) = $p.fetch('http://fpaste.scsys.co.uk/471157');
say "Summary: $summary";
say "Content: $content";

=end code

=head1 DESCRIPTION

This module allows to paste to L<http://fpaste.scsys.co.uk/> pastebin
as well as retrieve content from existing pastes.

=head1 METHODS

=head2 C<new>

=begin code :lang<raku>

my $p = Pastebin::Shadowcat.new;

=end code

Creates new C<Pastebin::Shadowcat> object.

=head2 C<paste>

=begin code :lang<raku>

my $paste_url = $p.paste('Paste content');

my $paste_url = $p.paste('Paste content', 'Optional summary');

=end code

B<Returns> URL to the created paste (e.g. L<http://fpaste.scsys.co.uk/471157>).
C<fail>s on error. B<Takes> one mandatory and one optional arguments:
the content to paste and optional sumary.

=head2 C<fetch>

=begin code :lang<raku>

my ($content,$summary) = $p.fetch('http://fpaste.scsys.co.uk/471157');

my ($content, $summary) = $p.fetch('471157');

=end code

B<Returns> a two-item list: paste content and paste summary.
C<fail>s on error. B<Takes> one mandatory argument: a full URL or just the
ID number of the paste you want to retrieve.


=head1 AUTHOR

Zoffix Znet

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 Zoffix Znet

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
