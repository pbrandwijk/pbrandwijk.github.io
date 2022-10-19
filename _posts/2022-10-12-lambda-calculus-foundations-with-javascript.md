---
layout:   post
title:    λ-calculus - Foundations with JavaScript
date:     2022-10-12 21:00:00 +0200
katex:    true
tags: 
 - Lambda calculus
 - JavaScript
 - Functional programming
 - node.js
---
*We explore the very core of lambda calculus using the JavaScript language. We build up propositional logic from scratch and use it to solve a logic puzzle.*

## Preparation
We will use an interactive REPL environment called `nodejs`. If you don't have that installed yet on your system, you can set up your system following the instructions [here](https://nodejs.org/en/). After installation you can open a terminal and start `nodejs`. If you want to load the file with the definitions [of this post](#complete-script), download the file `Lambda.js` to a folder and start `nodejs` from within that folder. Then use the `.load Lambda.js` command:
```console
$ ls
Lambda.js
$ nodejs
Welcome to Node.js v12.22.9.
Type ".help" for more information.
> .load Lambda.js
```

## Lambda calculus
In its simplest form, we can define the lambda calculus with the following terms[<sup>[1]</sup>][wiki1]:
- \\(x\\) - Variable. Can be any lambda expression.
- (\\(\lambda x.M\\)) - Function definition. \\(x\\) is bound in expression \\(M\\).
- (\\(M \thickspace N\\)) - Function application. Apply function \\(M\\) to argument \\(N\\).

This is all you need for a functioning lambda calculus. For the sake of readability though, I will add another term so that we can name our lambda expressions and reference back to them.
- \\(x = M\\) - variable assignment. \\(x\\) is substituted by \\(M\\) when used in an expression.

All of these terms are implemented in programming languages that support lambda expressions. Nowadays it's hard to find a language that doesn't support lambda expressions in one way or another. We will now use such an implementation and see if we can make some interesting programs with it.

## JavaScript representation
In this post we will build our lambdas in JavaScript, since it is a dynamically typed language and the latest versions of it provide a syntax for λ-expressions that stays quite close to the mathematical notation. The benefit of JavaScript being dynamically typed is that as our functions become more complex, we do not run into trouble with the automatic type inference system, like we would in a language like Haskell. 

This implementation draws heavily from other sources[<sup>[2]</sup>][computerphile] [<sup>[3]</sup>][klipse] [<sup>[5]</sup>][iitk], but has been ported to JavaScript. The syntax is somewhat different from the mathematical notation, which is shown here:
```javascript
x                          // variable
function(x) { return m; }  // function definition
(x => m)                   // shorthand function definition
m(n);                      // function application
let x = m;                 // variable assignment
```

## Boolean logic
So can we use our fresh JavaScript implementation of the lambda calculus to represent a basic data structure like Boolean logic? What would this look like? Suppose we define the Boolean terms `true` and `false` as follows[<sup>[3]</sup>][klipse] [<sup>[4]</sup>][rojas]:
\\[btrue = \lambda a.\lambda b.a\\]
\\[bfalse = \lambda a.\lambda b.b\\]
```javascript
let btrue = a => b => a;
let bfalse = a => b => b;
```
We use `btrue` and `bfalse` as function names instead of `true` and `false` to avoid conflicts with existing function definitions in the standard library of JavaScript. Notice that `btrue` and `bfalse` are defined as functions. So if some Boolean expression gives back a value, there is actually nothing for us to "see". But at some point we want to see the outcome of a calculation, so to do that we apply the following trick when executing the code in a REPL:
```javascript
> btrue(1)(0);
1
> bfalse(1)(0);
0
```
Here, `1` represents `true` and `0` represents `false`. I encourage you to experiment with this for yourself in the `nodejs` REPL.

### Not-operator
Now that we have defined `true` and `false`, are we able to define an operator for them? We will start with the not-operator (\\(\neg\\)), since it takes just a single argument. Consider the following implementation:
\\[bnot = \lambda a.a \thickspace F \thickspace T\\]
```javascript
let bnot = a => a(bfalse)(btrue);
```
Confirm for yourself that this indeed gives the expected behavior of the `not`-operator.

### And-operator
Now let's try the `and`-operator (\\(\land\\)). Of course this operator needs to take in two arguments. Try it first for yourself before looking at the following implementation:
\\[band = \lambda a.\lambda b.a \thickspace b \thickspace F\\]
```javascript
let band = a => b => a(b)(bfalse);
```

### Or-operator
With `and` and `not` we can already make all possible Boolean operators, but for fun let's also do the `or`-operator (\\(\lor\\)): 
\\[bor = \lambda a.\lambda b.a \thickspace T \thickspace b\\]
```javascript
let bor = a => b => a(btrue)(b);
```

## Conditional expression
We can also use the lambda calculus to define a conditional expression. It looks like this:
\\[bif = \lambda c.\lambda a.\lambda b.c \thickspace a \thickspace b\\]
```javascript
let bif = c => a => b => c(a)(b);
```
With this abstraction in the pocket, we can build some other constructs. Have a look:
```javascript
let bnot2 = a => bif(a)(bfalse)(btrue);
let bimplies = a => b => bif(band(a)(bnot(b)))(bfalse)(btrue);
```

This gives us quite some room to experiment with. As an exercise though, I encourage you to try for yourself and build some [other Boolean operators](https://en.wikipedia.org/wiki/Boolean_algebra#Secondary_operations).

## Testing
Of course we want to check that operators function correctly. For this we have to move a little bit outside of the purely functional lambda calculus, as we need some JavaScript expressions to print to the console:
```javascript
let line = a => b => "| " + a(1)(0) + " | " + b(1)(0) + " |   " 
           + bnot(a)(1)(0) + "   |    " + band(a)(b)(1)(0) + "    |   " 
           + bor(a)(b)(1)(0) + "    |      " + bimplies(a)(b)(1)(0) + "      |";

let test = function() { 
  console.log("| a | b | not a | a and b | a or b | a implies b |");
  console.log("|:-:|:-:|:-----:|:-------:|:------:|:-----------:|");
  console.log(line(bfalse)(bfalse));
  console.log(line(bfalse)(btrue));
  console.log(line(btrue)(bfalse));
  console.log(line(btrue)(btrue));
}
```
Running `test();` in `nodejs` will give you a nicely formatted truth table:
```javascript
> test();
| a | b | not a | a and b | a or b | a implies b |
|:-:|:-:|:-----:|:-------:|:------:|:-----------:|
| 0 | 0 |   1   |    0    |   0    |      1      |
| 0 | 1 |   1   |    0    |   1    |      1      |
| 1 | 0 |   0   |    0    |   1    |      0      |
| 1 | 1 |   0   |    1    |   1    |      1      |
```

## Knights and knaves
Now let's move on to some really cool stuff. Let's use our Boolean logic interpreter to solve some puzzles. Knights and knaves is a good starting point.[<sup>[6]</sup>][hku]

There is an island where each inhabitant is either a knight or a knave. The knights always tell the truth, the knaves always lie. The puzzle is to determine who is knight and who is knave, based on what the inhabitants say. Let's have a go.

Hubard says: "**Renart is a knave**". Renart says: "**Neither of us is a knight**".

To solve this puzzle, first we need to formulate it in terms that we can express in our Boolean language. We model variable `h` to express that Hubard is a knight. So when `h` is `true`, then Hubard is a knight (\\(Knight(H)\\)). When `h` is `false`, then Hubard is a knave (\\(Knave(H)\\)). We do the same for Renart, using variable `r`.

Now we model the statements that both made. Look at this formulation of the statement of Hubard:
\\[s1 = \lambda r. \neg r\\]

And now the statement of Renart:
\\[s2 = \lambda h. \lambda r. \neg h \land \neg r\\]

Notice that we can say that if Hubard is a knight, then \\(s1\\) must be `true`. If he is not a knight, then \\(\neg s1\\) must be `true`. The same goes for Renart and \\(s2\\). So now we can formulate the whole puzzle in the following way:
\\[check = \lambda h. \lambda r. (bif \thickspace (h) \thickspace (s1 \thickspace r) \thickspace (\neg (s1 \thickspace r))) \land (bif \thickspace (r) \thickspace (s2 \thickspace h \thickspace r) \thickspace (\neg (s2 \thickspace h \thickspace r)))\\]

This way, any assignment of `true` or `false` to `h` and `r` that makes `check` evaluate to `true`, is a solution to the puzzle. Let's put it into code:
```javascript
let s1 = r => bnot(r);
let s2 = h => r => band(bnot(h))(bnot(r));

let check = a => b => band(bif(a)(s1(b))(bnot(s1(b))))(bif(b)(s2(a)(b))(bnot(s2(a)(b))));

let solvePuzzle = function() {
  console.log(bif(check(bfalse)(bfalse))("Knave(H) and Knave(R)")(""));
  console.log(bif(check(bfalse)(btrue))("Knave(H) and Knight(R)")(""));
  console.log(bif(check(btrue)(bfalse))("Knight(H) and Knave(R)")(""));
  console.log(bif(check(btrue)(btrue))("Knight(H) and Knight(R)")(""));
}
```
Running `solvePuzzle();` in `nodejs` will print the solution to the puzzle:
```javascript
> solvePuzzle();


Knight(H) and Knave(R)

```
This concludes our crash course in λ-calculus. Feel free to experiment with the concepts that we have developed. Try for example to solve [some other][hku] knights and knaves puzzles.

## Complete script
<script src="https://gist.github.com/pbrandwijk/a11b074e71c11b00ea605c78d6ad38a3.js?file=Lambda.js"></script>

## Resources
- [[1] Lambda calculus - Wikipedia][wiki1]
- [[2] Lambda calculus - Computerphile][computerphile]
- [[3] Numbers representation in λ-calculus][klipse]
- [[4] A Tutorial Introduction to the Lambda Calculus][rojas]
- [[5] Untyped Lambda Calculus][iitk]
- [[6] Knights and knaves puzzles][hku]

[wiki1]: https://en.wikipedia.org/wiki/Lambda_calculus
[computerphile]: https://www.youtube.com/watch?v=eis11j_iGMs
[klipse]: https://blog.klipse.tech/lambda/2016/07/24/lambda-calculus-1.html
[rojas]: https://personal.utdallas.edu/~gupta/courses/apl/lambda.pdf
[iitk]: https://www.cse.iitk.ac.in/users/cs350/2011/lc1.pdf
[hku]: https://philosophy.hku.hk/think/logic/knights.php
