=encoding utf8

=for HTML <a href="https://travis-ci.org/zoffixznet/perl6-Pastebin-Shadowcat"><img src="https://travis-ci.org/zoffixznet/perl6-Pastebin-Shadowcat.svg?branch=master"></a>

=head1 NAME

Pastebin::Shadowcat - Raku interface to http://fpaste.scsys.co.uk/

=head1 SYNOPSIS

    use Pastebin::Shadowcat;

    my $p = Pastebin::Shadowcat.new;
    say "Pasting test content:";
    my $paste_url = $p.paste('<pre>test paste1</pre>', 'My optional summary');
    say "Paste is located at $paste_url";

    say "Retrieiving paste content:";
    my ( $content, $summary ) = $p.fetch('http://fpaste.scsys.co.uk/471157');
    say "Summary: $summary";
    say "Content: $content";

=head1 DESCRIPTION

This module allows to paste to L<http://fpaste.scsys.co.uk/> pastebin
as well as retrieve content from existing pastes.

=head1 METHODS

=head2 C<new>

    my $p = Pastebin::Shadowcat.new;

Creates new C<Pastebin::Shadowcat> object.

=head2 C<paste>

    my $paste_url = $p.paste('Paste content');
    my $paste_url = $p.paste('Paste content', 'Optional summary');

B<Returns> URL to the created paste (e.g. L<http://fpaste.scsys.co.uk/471157>).
C<fail>s on error. B<Takes> one mandatory and one optional arguments:
the content to paste and optional sumary.

=head2 C<fetch>

    my ( $content, $summary ) = $p.fetch('http://fpaste.scsys.co.uk/471157');

    my ( $content, $summary ) = $p.fetch('471157');

B<Returns> a two-item list: paste content and paste summary.
C<fail>s on error. B<Takes> one mandatory argument: a full URL or just the
ID number of the paste you want to retrieve.

=head1 REPOSITORY

Fork this module on GitHub:
L<https://github.com/raku-community-modules/Pastebin-Shadowcat>

=head1 BUGS

To report bugs or request features, please use
L<https://github.com/raku-community-modules/Pastebin-Shadowcat/issues>

=head1 AUTHOR

Zoffix Znet L<http://zoffix.com/>

=head1 LICENSE

You can use and distribute this module under the same terms as Raku
itself. See the C<LICENSE> file included in this distribution for complete
details.

=cut
