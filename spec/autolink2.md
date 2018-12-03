## Autolinks (extension)

GFM enables the `autolink` extension, where autolinks will be recognised in a
greater number of conditions.

[Autolink]s can also be constructed without requiring the use of `<` and to `>`
to delimit them, although they will be recognized under a smaller set of
circumstances.  All such recognized autolinks can only come at the beginning of
a line, after whitespace, or any of the delimiting characters `*`, `_`, `~`,
and `(`.

An [extended www autolink](@) will be recognized when the text `www.` is found
followed by a [valid domain]. A [valid domain](@) consists of alphanumeric
characters, underscores (`_`), hyphens (`-`) and periods (`.`).  There must be
at least one period, and no underscores may be present in the last two segments
of the domain.

The scheme `http` will be inserted automatically:

```````````````````````````````` example autolink
www.commonmark.org
.
<p><a href="http://www.commonmark.org">www.commonmark.org</a></p>
````````````````````````````````

After a [valid domain], zero or more non-space non-`<` characters may follow:

```````````````````````````````` example autolink
Visit www.commonmark.org/help for more information.
.
<p>Visit <a href="http://www.commonmark.org/help">www.commonmark.org/help</a> for more information.</p>
````````````````````````````````

We then apply [extended autolink path validation](@) as follows:

Trailing punctuation (specifically, `?`, `!`, `.`, `,`, `:`, `*`, `_`, and `~`)
will not be considered part of the autolink, though they may be included in the
interior of the link:

```````````````````````````````` example autolink
Visit www.commonmark.org.

Visit www.commonmark.org/a.b.
.
<p>Visit <a href="http://www.commonmark.org">www.commonmark.org</a>.</p>
<p>Visit <a href="http://www.commonmark.org/a.b">www.commonmark.org/a.b</a>.</p>
````````````````````````````````

When an autolink ends in `)`, we scan the entire autolink for the total number
of parentheses.  If there is a greater number of closing parentheses than
opening ones, we don't consider the last character part of the autolink, in
order to facilitate including an autolink inside a parenthesis:

```````````````````````````````` example autolink
www.google.com/search?q=Markup+(business)

(www.google.com/search?q=Markup+(business))
.
<p><a href="http://www.google.com/search?q=Markup+(business)">www.google.com/search?q=Markup+(business)</a></p>
<p>(<a href="http://www.google.com/search?q=Markup+(business)">www.google.com/search?q=Markup+(business)</a>)</p>
````````````````````````````````

This check is only done when the link ends in a closing parentheses `)`, so if
the only parentheses are in the interior of the autolink, no special rules are
applied:

```````````````````````````````` example autolink
www.google.com/search?q=(business))+ok
.
<p><a href="http://www.google.com/search?q=(business))+ok">www.google.com/search?q=(business))+ok</a></p>
````````````````````````````````

If an autolink ends in a semicolon (`;`), we check to see if it appears to
resemble an [entity reference][entity references]; if the preceding text is `&`
followed by one or more alphanumeric characters.  If so, it is excluded from
the autolink:

```````````````````````````````` example autolink
www.google.com/search?q=commonmark&hl=en

www.google.com/search?q=commonmark&hl;
.
<p><a href="http://www.google.com/search?q=commonmark&amp;hl=en">www.google.com/search?q=commonmark&amp;hl=en</a></p>
<p><a href="http://www.google.com/search?q=commonmark">www.google.com/search?q=commonmark</a>&amp;hl;</p>
````````````````````````````````

`<` immediately ends an autolink.

```````````````````````````````` example autolink
www.commonmark.org/he<lp
.
<p><a href="http://www.commonmark.org/he">www.commonmark.org/he</a>&lt;lp</p>
````````````````````````````````

An [extended url autolink](@) will be recognised when one of the schemes
`http://`, `https://`, or `ftp://`, followed by a [valid domain], then zero or
more non-space non-`<` characters according to
[extended autolink path validation]:

```````````````````````````````` example autolink
http://commonmark.org

(Visit https://encrypted.google.com/search?q=Markup+(business))

Anonymous FTP is available at ftp://foo.bar.baz.
.
<p><a href="http://commonmark.org">http://commonmark.org</a></p>
<p>(Visit <a href="https://encrypted.google.com/search?q=Markup+(business)">https://encrypted.google.com/search?q=Markup+(business)</a>)</p>
<p>Anonymous FTP is available at <a href="ftp://foo.bar.baz">ftp://foo.bar.baz</a>.</p>
````````````````````````````````


An [extended email autolink](@) will be recognised when an email address is
recognised within any text node.  Email addresses are recognised according to
the following rules:

* One ore more characters which are alphanumeric, or `.`, `-`, `_`, or `+`.
* An `@` symbol.
* One or more characters which are alphanumeric, or `.`, `-`, or `_`. At least
  one of the characters here must be a period (`.`).  The last character must
  not be one of `-` or `_`.  If the last character is a period (`.`), it will
  be excluded from the autolink.

The scheme `mailto:` will automatically be added to the generated link:

```````````````````````````````` example autolink
foo@bar.baz
.
<p><a href="mailto:foo@bar.baz">foo@bar.baz</a></p>
````````````````````````````````

`+` can occur before the `@`, but not after.

```````````````````````````````` example autolink
hello@mail+xyz.example isn't valid, but hello+xyz@mail.example is.
.
<p>hello@mail+xyz.example isn't valid, but <a href="mailto:hello+xyz@mail.example">hello+xyz@mail.example</a> is.</p>
````````````````````````````````

`.`, `-`, and `_` can occur on both sides of the `@`, but only `.` may occur at
the end of the email address, in which case it will not be considered part of
the address:

```````````````````````````````` example autolink
a.b-c_d@a.b

a.b-c_d@a.b.

a.b-c_d@a.b-

a.b-c_d@a.b_
.
<p><a href="mailto:a.b-c_d@a.b">a.b-c_d@a.b</a></p>
<p><a href="mailto:a.b-c_d@a.b">a.b-c_d@a.b</a>.</p>
<p>a.b-c_d@a.b-</p>
<p>a.b-c_d@a.b_</p>
````````````````````````````````

</div>

