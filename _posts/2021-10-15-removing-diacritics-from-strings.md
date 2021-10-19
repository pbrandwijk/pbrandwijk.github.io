---
layout:   post
title:    "Removing diacritics from strings"
date:     2021-10-15 21:00:00 +0200
tags:
 - javascript
 - strings
 - node.js
 - unicode
---
*Ever wondered what actually happens when you use the normalize function to remove diacritics from a string? This post will tell you.*

## Preliminaries
I'm using Ubuntu 20.04 as my OS. Also, you need the `Node.js` REPL installed with:

```console
$ sudo apt install nodejs
$ node   # Start the REPL
```

## Use cases
For quite a few purposes you may need to reduce a string to a set of "simple" characters, for example to create a slug for a URL. In Java and JavaScript this can be done efficiently using string normalization. 

Normalizing a string means that any character containing a diacritical mark is split up in to two characters, one base character and one with the so-called combining diacritical mark. Since all these marks fall into a specific range of unicode characters, it then becomes easy to filter them out.

### Representation of diacritical marks
In the below table an example is given of how the letter `é` can be represented. The first row shows the representation that is most often used, namely a single unicode character that contains both the base character and the accent. In the next three rows I show how the separate base character, combined with the acute accent character can give the same result. Depending on the font, you will either see a difference in the size and location of the accent, or you will hardly see any difference at all. If you want to, you can confirm that they are indeed different using a tool like [this one][unicodeconverter].

| Code | Character |
|---|---|
| U+00E9 | é |
| U+0065 | e |
| U+0301 | ◌́ (acute accent - combining diacritical mark) |
| U+0065U+0301 | é |
|||

To experiment with this yourself, you can input a unicode character directly by its number in Ubuntu linux using the key combination `Ctrl+Shift+U` followed by the hexadecimal code of the character. For an overview of unicode characters and their codes, [check here][unicodetable].

## Example
In the below Node.js REPL session you can see the two phases of removing diacritics. First the string is normalized, then all characters in the combining diacritical marks range are removed. Lastly, I show how you can use the normalized string to replace the base characters while keeping the diacritical marks where they are.

```javascript
// Create a string using "regular" characters with diacritics
> const a = "Crème Brulée"
> a
'Crème Brulée'
// Use the standard normalize function
> const b = a.normalize("NFD");
> b
'Crème Brulée'
// Now filter out the combining diacritical marks
> const c = b.replace(/[\u0300-\u036f]/g,"");
> c
'Creme Brulee'
// Bonus: Check what happens when replacing the base character in the normalized string
> const d = b.replace(/e/g,"a");
> d
'Cràma Bruláa'
```

If you copy these assignments to a Node.js REPL you can experiment with this for yourself.

## Resources
- [Combining diacritical marks][unicodetable]
- [Unicode converter][unicodeconverter]
- [Unicode normalization forms][normalizationforms]

[unicodetable]: https://unicode-table.com/en/blocks/combining-diacritical-marks/
[unicodeconverter]: https://r12a.github.io/app-conversion/
[normalizationforms]: http://www.unicode.org/reports/tr15/