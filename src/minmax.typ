#import "@local/evan:1.0.0":*

= Critical points

== [TEXT] Critical points in 18.01

First, a comparison to 18.01.
Way back when you had a differentiable single-variable function $f : RR -> RR$,
and you were trying to minimize it, you used the following terms:

#figure(
  table(
    columns: 2,
    align: left,
    table.header([18.01 term], [Meaning]),
    [Global minimum], [Minimum of the function $f$ across the entire region you're considering],
    [Local minimum], [A point at which $f$ is smaller than any nearby points in a small neighborhood],
    [Critical point], [A point where $f'(x) = 0$],
  ),
  kind: table,
  caption: [18.01 terminology for critical points]
)
Each row includes all the ones below it, but not vice-versa.
Here's a picture of an example showing these for
a random function $f(x) = -1/5 x^6 - 2/7 x^5 + 2/3 x^4 + x^3$.
From left to right in @fig-1801-critical-points, there are four critical points:

- A local maximum (that isn't a global maximum), drawn in blue.
- A local minimum (that isn't a global minimum), draw in green.
- An critical inflection point --- neither a local minimum _nor_ a local maximum. Drawn in orange.
- A global maximum, drawn in purple.

Note there's no global minimum at all, since the function $f$ goes to $-oo$ in both directions
as $x -> -oo$ or $x -> +oo$.

#figure(
  image("figures/minmax-1801graph.png", width: auto),
  caption: [Some examples of critical points in an 18.01 graph of a single variable function.],
) <fig-1801-critical-points>

== [TEXT] Critical points in 18.02 <sec-critical-points>

In 18.02, when we consider $f : RR^n -> RR$ the only change we make is:

#definition[
  For 18.02, we generalize the definition of *critical point* to be a point $P$
  for which $nabla f (P) = bf(0)$ is the zero vector.
  (The other two definitions don't change.)
]

As soon as I say this I need to carry over the analogous warnings from 18.01:
#warning[
  - Keep in mind that each of the implications
    $ "Global minimum" ==> "Local minimum" ==> "Critical point, i.e. " nabla f = bf(0) $
    is true only one way, not conversely.
    So a local minimum may not be a global minimum;
    and a point with gradient zero might not be a minimum, even locally.
    You should still find all the critical points,
    just be aware a lot of them may not actually be min's or max's.
  - There may not be _any_ global minimum or maximum at all, like we just saw.
]

#definition[
  In 18.02, a critical point that isn't a local minimum or maximum is called a *saddle point*.
]

#example[
  The best example of a saddle point to keep in your head is the origin for the function
  $ f(x,y) = x^2 - y^2. $
  Why is this a saddle point? We have $f(0,0) = 0$, and the gradient is zero too, since
  $ nabla f = vec(2x, 2y) ==> nabla f (0,0) = vec(2 dot 0, 2 dot 0) = vec(0, 0). $
  The problem is that the small changes in $x$ and $y$ clash in sign.
  Specifically, if we go a little bit to either the left or right in the $x$-direction,
  then $f$ will _increase_ a little bit, e.g.
  $ f(0.1, 0) = f(-0.1, 0) = 0.01 > 0. $
  But the $-y^2$ term does the opposite: if we go a little bit up or down in the $y$-direction,
  then $f$ will _decrease_ a little bit.
  $ f(0, 0.1) = f(0, -0.1) = -0.01 < 0. $
  So the issue is the clashing signs of small changes in $x$ and $y$ directions.
  This causes $f$ to neither be a local minimum nor local maximum.

  There's actually nothing special about $plus.minus x$ and $plus.minus y$ in particular;
  I only used those to make arithmetic easier.
  You can see @fig-hyperbola-saddle for values of $f$ at other nearby points.
]

#figure(
  image("figures/minmax-hyperbola-saddle.png", width: auto),
  caption: [Values of $f(x,y) = x^2-y^2$ at a distance of $0.1$ from the saddle point $(0,0)$.
    Green values are positive and red ones are negative.
    It's a saddle point because there are both.
  ],
) <fig-hyperbola-saddle>


#remark[
  The name "saddle point" comes from the following picture: if one looks at the surface
  $ z = x^2 - y^2 $
  then near $(0,0)$ you have something that looks like a horse saddle.
  It curves upwards along the $x$-direction, but downwards along the $y$-direction.
]

We'll get to the recipe for distinguishing
between saddle points and local minimums and maximums in a moment;
like in 18.01, there is something called the second derivative test.
First, one digression and a few examples of finding critical points.

== [SIDENOTE] Saddle points are way more common than critical inflection points <sec-saddle-sim>

At first glance, you might be tempted to think that a saddle point
is the 18.02 version of the critical inflection point.
However, that analogy is actually not so good for your instincts,
and *saddle points feel quite different from 18.01 critical inflection points*.
Let me explain why.

In 18.01, it was _possible_ for a critical point to be neither a local minimum or maximum,
and we called these inflection points.
However, in 18.01 this was actually really rare.
To put this in perspective, suppose we considered a random 18.01 function of the form
$ f(x) = square x^3 + square x^2 + square x + square $
where each square was a random integer between $-1000000$ and $1000000$ inclusive.
Of the approximately $10^(25)$ functions of this shape,
you will find that while there are plenty of critical points,
the chance of finding an inflection point is something like $10^(-15)$ ---
far worse than the lottery.
(Of course, if you _know_ where to look, you can find inflection points:
$f(x) = x^3$ has an inflection point at the origin, for example.)

In 18.02 this is no longer true.
If we picked a random function of a similar form
$ f(x) = square x^3 + square x^2 + square x + square y^3 + square y^2 + square y + square $
where we fill each square with a number from $-1000000$ to $1000000$
then you'll suddenly see saddle points everywhere.
For example, when I ran this simulation $10000$ times,
among the critical points that showed up, I ended up with about

- 24.6% local minimums
- 25.3% local maximums
- 50.1% saddle points.

And the true limits (if one replaces $10^6$ with $N$ and takes the limit as $N -> oo$)
are what you would guess from the above: 25%, 25%, 50%.
(If you want to see the code, it's in the Appendix, section @appendix-saddle-sim.)

Why is the 18.02 situation so different?
It comes down to this: in 18.02, you can have two clashing directions.
For the two experiments I've run here, consider the picture in @fig-whysaddle.
Here $P$ is a critical point,
and we consider walking away from it in one of two directions.
I'll draw a blue $+$ arrow if $f$ increases, and a red $-$ arrow if $f$ decreases.

#figure(
  image("figures/minmax-whysaddle.png", width: auto),
  caption: [Why the 18.01 and 18.02 polynomial experiments have totally different outcomes.],
) <fig-whysaddle>

In the 18.01 experiment, we saw that two arrows pointing _opposite_ directions
almost always have the same color.
So in 18.01, when we could only walk in one direction,
that meant almost every point was either a local minimum or a local maximum.
But the picture for 18.02 is totally different because there's nothing that forces
the north/south pair to have a different direction from the east/west pair.
For a "random" function, if you believe the colors are equally likely,
then half the time the arrows don't match colors and you end up with a saddle point.

This whole section was for two-variable functions $P(x) + Q(y)$, so it's already a simplification.
If you ran an analogous three-variable experiment defined similarly for
polynomials $f(x,y,z) = P(x) + Q(y) + R(z)$:

- 12.5% local minimums
- 12.5% local maximums
- 75.0% saddle points.

If we return to the world of _any_ two-variable function, the truth is even more complicated than this.
In this sidenote I only talked about functions $f(x,y)$
that looked like $P(x) + Q(y)$ where $P$ and $Q$ were polynomials.
The $x$ and $y$ parts of the function were completely unconnected,
so we only looked in the four directions north/south/east/west.
But most two-variable functions have some more dependence between $x$ and $y$,
like $f(x,y) = x^2y^3$ or $f(x) = e^x sin(y)$ or similar.
Then you actually need to think about more directions than just north/south/east/west.
#digression[
  For example, Poonen's lecture notes (see question 9.22) show a weird _monkey saddle_:
  the point $(0,0)$ is a critical point of
  $ f(x,y) = x y (x-y) $
  where the values of $f$ nearby split into six regions, alternating negative and positive,
  in contrast to @fig-hyperbola-saddle where there were only four zones on the circle.
  (See also #link("https://w.wiki/6LLG")[Wikipedia for monkey saddle].)
  Poonen also invites the reader to come up with an _octopus saddle_
  (which sounds like it needs sixteen regions, eight down ones for each leg of the octopus).
]

== [RECIPE] Finding critical points

For finding critical points, on paper you can just follow the definition:

#recipe(title: [Recipe for finding critical points])[
  To find the critical points of $f : RR^n -> RR$

  1. Compute the gradient $nabla f$.
  2. Set it equal to the zero vector and solve the resulting system of $n$ equations in $n$ variables.
]

The thing that might be tricky is that you have to solve a system of equations.
Depending on how difficult your function is to work with, that might require some
creativity in order to get the algebra right.
We'll show some examples where the algebra is really simple,
and examples where the algebra is much more involved.

#sample[
  Find the critical points of $f(x,y,z) = x^2 + 2 y^2 + 3 z^2$.
]
#soln[
  The gradient is
  $ nabla f (x,y,z) = vec(2x, 4y, 6z). $
  In order for this to equal $vec(0,0,0)$, we need to solve the three-variable system of equations
  $
  2x &= 0 \
  4y &= 0 \
  6z &= 0 \
  $
  which is so easy that it's almost insulting: $x=y=z=0$.
  The only critical point is $(0,0,0)$.
]

#sample[
  Find the critical points of $f(x,y) = x y (6 - x - y)$.
]
#soln[
  This example is a lot more annoying than the previous one, despite having fewer variables,
  because casework is forced upon you.
  You need to solve four systems of linear equations, not just one, as you'll see.

  We expand $ f(x,y) = 6 x y - x^2 y - x y^2. $
  So $ nabla f = vec(6 y - 2 x y - y^2, 6 x - x^2 - 2 x y). $
  Hence, the resulting system of equations to solve is
  $
    y (6 - 2 x - y) &= 0 \
    x (6 - 2 y - x) &= 0.
  $
  The bad news is that these are quadratic equations.
  Fortunately, they come in factored form, so we can rewrite them as OR statements:
  $
    y (6 - 2 x - y) &= 0 ==> (y = 0 " OR " 2x + y = 6) \
    x (6 - 2 y - x) &= 0 ==> (x = 0 " OR " x + 2y = 6).
  $
  So actually there are $2^2 = 4$ cases to consider, and we have to manually tackle all four.
  These cases fit into the following $2 times 2$ table; we solve all four systems of equations.
  #align(center)[
    #block(breakable: false)[
      #table(
        columns: 3,
        align: left + horizon,
        stroke: 0.5pt,
        [], [Top eqn.~gives $y=0$], [Top eqn.~gives $2x+y=6$],
        [Bottom eqn.~gives $x=0$], [$cases(y=0, x=0) ==> (x,y) = (0,0)$], [$cases(2x+y=6 \ x=0) ==> (x,y) = (0,6)$],
        [Bottom eqn.~gives $x+2y=6$], [$cases(y=0, x+2y=6) ==> (x,y)=(6,0)$], [$cases(2x+y=6, x+2y=6) ==> (x,y) = (2,2)$]
      ),
    ]
  ]
  So we get there are four critical points, one for each case: $(0,0)$, $(0,6)$, $(6,0)$ and $(2,2)$.
]

== [RECIPE] The second derivative test for two-variable functions

Earlier we classified critical points by looking at nearby points.
Technically speaking, we did not give a precise definition of "nearby", just using
small numbers like $0.01$ or $0.1$ to make a point.
So in 18.02, the exam will want a more systematic theorem for classifying
critical points as local minimum, local maximum, or saddle point.

I thought for a bit about trying to explain why the second derivative test works,
but ultimately I decided to not include it in these notes.
Here's some excuses why:
#digression[
  The issue is that getting the "right" understanding of this would require
  me to talk about _quadratic forms_.
  However, in the prerequisite parts Alfa and Bravo of these notes,
  we only did linear algebra, and didn't cover quadratic forms in this context at all.
  I hesitate to introduce an entire chapter on quadratic forms
  (which are much less intuitive than linear functions) and _then_ tie that to eigenvalues
  of a $2 times 2$ just to justify a single result that most students will just memorize anyway.

  Poonen has some hints on quadratic forms in section 9 of his notes if you want to look there though.

  The other downside is that even if quadratic forms are done correctly,
  the second derivative test doesn't work in all cases anyway,
  if the changes of the function near the critical point are sub-quadratic (e.g. degree three).
  And multivariable Taylor series are not on-syllabus for 18.02.
]

So to get this section over with quickly, I'll just give the result.
I'm sorry this will seem to come out of nowhere.

#recipe(title: [Recipe: the second derivative test])[
  Suppose $f(x,y)$ is a function has a critical point at $P$.
  We want to tell whether it's a local minimum, local maximum, or saddle point.
  Assume that $f$ has a continuous second derivative near $P$.

  1. Let $A = f_(x x) (P)$, $B = f_(x y) (P) = f_(y x) (P)$, $C = f_(y y) (P)$.
    These are the partial derivatives of the partial derivatives of $f$ (yes, I'm sorry),
    evaluated at $P$.
    If you prefer gradients, you could write this instead as
    $ nabla f_x = vec(A,B), #h(1em) nabla f_y = vec(B,C). $

  2. If $A C - B^2 != 0$, output the answer based on the following chart:
    - If $A C - B^2 < 0$, output "saddle point".
    - If $A C - B^2 > 0$ and $A, C >= 0$, output "local minimum".
    - If $A C - B^2 > 0$ and $A, C <= 0$, output "local maximum".
  3. If $A C - B^2 = 0$, the second derivative test is inconclusive.
    Any of the above answers are possible, including weird/rare saddle points like the monkey saddle.
    You have to use a different method instead.
]

#tip[
  It is indeed a theorem that if $f$ is differentiable twice continuously, then $f_(x y) = f_(y x)$.
  That is, if you take a well-behaved function $f$ and differentiate with respect to $x$
  then differentiate with respect to $y$,
  you get the same answer as if you differentiate with respect to $y$ and respect to $x$.
]

#sample[
  Use the second derivative test to classify the critical point $(0,0)$ of
  the function $ f(x,y) = x^3 + x^2 + y^3 - y^2. $
  (We already know it's going to be a saddle point from the example in @sec-critical-points.)
]
#soln[
  Start by computing the partial derivatives:
  $ nabla f = vec(3x^2 + 2x, 3y^2 - 2y) ==> cases(f_x = 3x^2 + 2x, f_y = 3y^2 - 2y). $
  We now do partial differentiation a second time on each of these.
  Depending on your notation, you can write this as either
  $ nabla f_x = vec(6x+2,0) #h(1em) nabla f_y = vec(0,6y-2) $
  or
  $ f_(x x) = 6x+2, #h(1em) f_(x y) = f_(y x) = 0, #h(1em) f_(y y) = 6y-2. $
  Again, the repeated $f_(x y) = f_(y x)$ is either $(partial) / (partial y) (6x+2) = 0$
  or $(partial) / (partial x) (6y-2) = 0$;
  for well-behaved functions, you always get the same answer.

  At the origin, we get
  $
  A &= 6 dot 0 + 2 = 2 \
  B &= 0 \
  C &= 6 dot 0 - 2 = -2.
  $
  Since $A C - B^2 = -4 < 0$, we output the answer "saddle point".
]

#sample[
  Find the critical points of $f(x,y) = x y + y^2 + 2 y$
  and classify them using the second derivative test.
]
#soln[
  Start by computing the gradient:
  $ nabla f = vec(y, x + 2 y + 2). $
  Solve the system of equations $y = 0$ and $x + 2y + 2 = 0$ to get just $(x,y) = (-2,0)$.
  Hence this is the only critical point.

  We now compute the second derivatives:
  $
  f_(x x) &= (partial)/(partial x) (y) = 0 \
  f_(x y) = f_(y x) &= (partial)/(partial y) (y) = (partial)/(partial x)(x + 2 y + 2) = 1 \
  f_(y y) &= (partial)/(partial y) (x + 2 y + 2) = 2.
  $
  These are all constant functions in this example;
  anyway, we have $A = 0$, $B = 1$, $C = 2$, and $A C - B^2 = -1 < 0$,
  so we this critical point is a saddle point.
]

== [EXER] Exercises


#exerstar[
  - Give an example of a differentiable function $f : RR^2 -> RR$ with the following property:
    for every point $(x,y)$, the point $(x,y)$ is a saddle point if and only if
    $x$ and $y$ are both integers.
  - Does there exist a differentiable function $f : RR^2 -> RR$
    such that every point is a saddle point?
]

#pagebreak()

= Optimization problems

== [TEXT] Dimension and boundary

== [TEXT]

== [RECIPE] Unconstrained optimization

#pagebreak()

= Lagrange multipliers