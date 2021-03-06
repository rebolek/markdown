## Strikethrough (extension)

GFM enables the `strikethrough` extension, where an additional emphasis type is
available.

Strikethrough text is any text wrapped in two tildes (`~`).

```````````````````````````````` example strikethrough
~~Hi~~ Hello, world!
.
<p><del>Hi</del> Hello, world!</p>
````````````````````````````````

As with regular emphasis delimiters, a new paragraph will cause strikethrough
parsing to cease:

```````````````````````````````` example strikethrough
This ~~has a

new paragraph~~.
.
<p>This ~~has a</p>
<p>new paragraph~~.</p>
````````````````````````````````

</div>

