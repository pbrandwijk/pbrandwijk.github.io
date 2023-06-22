---
layout:   post
title:    "Propositional logic for data conditions"
date:     2023-05-16 23:00:00 +0200
tags:     
 - propositional logic
---
*Example of how to use propositional logic to help model data conditions*

## Scenario
Suppose you are working on the backend of a data store with product data for a retail company. A new requirement comes in that looks like this:
- Products taller than 30 cm that are classified as web store products and are linked to a supplier located in Germany need to be reviewed by data management before been marked as available for sale.



## Naive solution
Code that looks like this:
```javascript
if (product.height > 30 && product.hasClassification("WebStore") && product.getSupplier().country == "Germany") {

}
```

## Using propositional logic
Model the requirement as follows:
 p | q | r | result
---|---|---|---
 0 | 0 | 0 | -
 0 | 0 | 1 | Send to DM
 
```javascript
let p = product.height > 30;
let q = product.hasClassification("WebStore");
let r = product.getSupplier().country == "Germany";

if (p && q && !r) {
    product.initiateReviewDM();
}
```


## Resources
- [How to mount smb share on ubuntu 18.04][askubuntu]
- [How to Mount Windows Share on Linux using CIFS][linuxize]

[askubuntu]: https://askubuntu.com/questions/1050460/how-to-mount-smb-share-on-ubuntu-18-04
[linuxize]: https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/