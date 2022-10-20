---
layout:   post
title:    XML to JSON conversion?
date:     2022-10-19 22:10:00 +0200
katex:    false
tags: 
 - XML
 - JSON
---
*Is there a way to convert an arbitrary XML document into JSON without losing data?*

## Scoping the question
Even though the XML standard is a very concise document[<sup>[1]</sup>][xml] of only a few pages, there are still quite some parts of it that would make a complete translation quite complicated for a single blog post. Think about the comments, white space, CDATA sections, etc. 

We will also leave out the concepts of name spaces and schema definitions. So in this post we will focus only on XML elements, attributes and their contents. Other parts of the XML standard are out of scope. Handling escaped or reserved characters in either the XML or the JSON document is also out of scope.

## Exploring the problem space
The challenge lies in the question of how to translate the concept of nested XML elements and the attributes that an element may have to JSON constructs. JSON knows the following constructs[<sup>[2]</sup>][json]:
- `objects`, which consist of properties
- `properties`, consisting of a name and a value
- `values`, which can be either be:
  - an `object`
  - an `array` of `values`
  - a base type `value`:
    - a `string`
    - a `number`
    - a `boolean`
    - `null`

We need to find a way of using these constructs to unambiguously express the same data as the XML. That means it must be possible for the XML document that was converted to JSON to be converted back to the same XML document, and ONLY to that document.

Let's first tackle the elements. Elements can contain nothing, textual content or one or more elements. It seems intuitive to translate them into JSON objects. An element then becomes an object with the following properties:
- `name`: gets a string value that is equal to the name of the element
- `content`: gets one of the following values:
  - the `null` value (for an empty element)
  - a `string` that is equal to the textual content of the element
  - an `array` that contains the objects representing the nested elements

Now we are left with the attributes. But now that we have the scaffolding of the translation of an element, it is straightforward to see that all we have to do is to add another property to the JSON objects:
- `attributes`: gets one of the following values: 
  - the `null` value, if the element has no attributes
  - an `array` of one object per attribute with the following properties:
    - `name`: gets a string value that is equal to the name of the attribute
    - `content`: gets a string that is equal to the textual content of the attribute

To keep the order of the XML document preserved, it is required that in the JSON document both nested elements and attributes keep the same order as in the original document.

Notice that all textual content of the XML is translated a JSON `string` base type value. There is no interpretation of this content as numbers or booleans.

## Example
Let's put the mapping that we have defined to the test on an XML document that contains a broad range of different combinations of XML elements and attributes.

**XML document**
```xml
<books>
  <book isbn="9798615591839" language="en_EN">
    <name attribute="Clever way of putting a logic concept in the title">Program = proof</name>
    <pro>Learn lambda calculus and formal proofs</pro>
    <con></con>
  </book>
  <book isbn="9788417859459" language="es_ES">
    <name attribute="">El laberinto de Flandes</name>
    <pro></pro>
    <con>Tough to read</con>
  </book>
</books>
```

**Translation to JSON**
```json
{
  "name": "books",
  "attributes": null,
  "content": [
    {
      "name": "book",
      "attributes": [
        {
          "isbn": "9798615591839"
        },
        {
          "language": "en_EN"
        }
      ],
      "content": [
        {
          "name": "name",
          "attributes": [
            {
              "attribute": "Clever way of putting a logic concept in the title"
            }
          ],
          "content": "Program = proof"
        },
        {
          "name": "pro",
          "attributes": null,
          "content": "Learn lambda calculus and formal proofs"
        },
        {
          "name": "con",
          "attributes": null,
          "content": null
        }
      ]
    },
    {
      "name": "book",
      "attributes": [
        {
          "isbn": "9788417859459"
        },
        {
          "language": "es_ES"
        }
      ],
      "content": [
        {
          "name": "name",
          "attributes": [
            {
              "attribute": ""
            }
          ],
          "content": "El laberinto de Flandes"
        },
        {
          "name": "pro",
          "attributes": null,
          "content": null
        },
        {
          "name": "con",
          "attributes": null,
          "content": "Tough to read"
        }
      ]
    }
  ]
}
```

## Alternative solutions
I have seen an online converter[<sup>[3]</sup>][convertjson] that produces shorter documents than the mapping proposed in this post. It differs in that it puts nested elements with the same name together under one property. This saves space, but if there are nested elements with the same name and some with another name, then you can't preserve the order of the elements.

It also uses underscore prefixes to "mark" property names as representing attributes or text. This gives a much shorter translation, but adds complexity when parsing the document.

## Conclusion
It is clearly possible to transform an arbitrary XML document (within the scope that we have defined) to JSON. The resulting JSON file does get quite a bit longer with the translation mapping that we have chosen. Other mappings exist with their own pro's and cons. 

The next step is to formalize the mapping defined in this post into a program that can perform the translation automatically.

## Resources
- [[1] Extensible Markup Language (XML) 1.0][xml]
- [[2] ECMA-404 The JSON Data Interchange Standard][json]
- [[3] Convert XML To JSON][convertjson]

[xml]: https://www.xml.com/axml/axml.html
[json]: https://www.json.org/json-en.html
[convertjson]: https://www.convertjson.com/xml-to-json.htm