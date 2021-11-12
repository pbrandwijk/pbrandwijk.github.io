---
layout:   post
title:    Next next level Pareto
date:     2021-10-20 21:20:00 +0200
katex:    true
tags:     
 - Pareto principle
---
*Let's take the Pareto principle to the next next level!*

## Pareto's principle
I doubt there is anyone who hasn't heard of Pareto's principle. It states that 20% of effort gives 80% of results. The other 80% of effort is good for the last 20% of results. Applying this pragmatically to your life, this means you focus on the few actions you can take that give you maximum output. Everything else is basically waste.

## Next next level
In this post I want to take this principle two steps further. Why two? We shall see in a moment. If the Pareto principle applies to essentially anything and everything, then it should also apply to itself. In other words, it should be recursive.

So what becomes interesting now is to ask, what extremely little effort can I do, to expect a huge benefit? And how huge of a benefit can I expect?

If 0.2 times the effort gives 0.8 times the result, then 0.2 times 0.2 times the effort should give 0.8 times 0.8 times the result. This adds up quickly, look at this: 
\\[(0.2^1 = 20\%) \mapsto (0.8^1 = 80\%)\\]
\\[(0.2^2 = 4\%) \mapsto (0.8^2 = 64\%)\\]
\\[(0.2^3 \approx 1\%) \mapsto (0.8^3 \approx 50\%)\\]

This shows that if you apply the Pareto principle three times, then 1% of effort gives about 50% of the results. In other words, with a tiny action, I can literally come half way. Not bad! The trick is of course, to find out what action that is.

Bonus: what happens when you invert the above relation? That is, instead of applying the 20% rule to itself, meaning we square it (\\(20\% * 20\% = 0.2^2 = 4\%\\)), we invert it by taking the square root instead. This gives \\((0.2^\frac{1}{2} \approx 45\%) \mapsto (0.8^\frac{1}{2} \approx 90\%)\\), meaning 45% of effort gives you about 90% of results. Notice that by adding 25 Percentage Points of effort, you only gain 10 Percentage Points of results.

<!--
{% gist 04a9fff84e281a7024b2f7cdb2ec2211 Pareto.hs %}
-->
