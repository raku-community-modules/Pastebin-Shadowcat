[![Actions Status](https://github.com/raku-community-modules/Pastebin-Shadowcat/workflows/test/badge.svg)](https://github.com/raku-community-modules/Pastebin-Shadowcat/actions)

NAME
====

Pastebin::Shadowcat - Raku interface to http://fpaste.scsys.co.uk/

SYNOPSIS
========

```raku
use Pastebin::Shadowcat;

my $p = Pastebin::Shadowcat.new;
say "Pasting test content:";
my $paste_url = $p.paste('<pre>test paste1</pre>', 'My optional summary');
say "Paste is located at $paste_url";

say "Retrieiving paste content:";
my ( $content, $summary ) = $p.fetch('http://fpaste.scsys.co.uk/471157');
say "Summary: $summary";
say "Content: $content";
```

DESCRIPTION
===========

This module allows to paste to [http://fpaste.scsys.co.uk/](http://fpaste.scsys.co.uk/) pastebin as well as retrieve content from existing pastes.

METHODS
=======

`new`
-----

```raku
my $p = Pastebin::Shadowcat.new;
```

Creates new `Pastebin::Shadowcat` object.

`paste`
-------

```raku
my $paste_url = $p.paste('Paste content');

my $paste_url = $p.paste('Paste content', 'Optional summary');
```

**Returns** URL to the created paste (e.g. [http://fpaste.scsys.co.uk/471157](http://fpaste.scsys.co.uk/471157)). `fail`s on error. **Takes** one mandatory and one optional arguments: the content to paste and optional sumary.

`fetch`
-------

```raku
my ($content,$summary) = $p.fetch('http://fpaste.scsys.co.uk/471157');

my ($content, $summary) = $p.fetch('471157');
```

**Returns** a two-item list: paste content and paste summary. `fail`s on error. **Takes** one mandatory argument: a full URL or just the ID number of the paste you want to retrieve.

AUTHOR
======

Zoffix Znet

COPYRIGHT AND LICENSE
=====================

Copyright 2015 - 2017 Zoffix Znet

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

