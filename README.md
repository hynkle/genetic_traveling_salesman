# Genetic Algorithm to Solve Traveling Salesman Problem

## What is this project?

This project is a reimplementation of an old university of assignment of mine.
My original solution to the problem worked in roughly the same way, but it was
written when I did not know Ruby well at all and was fairly new to programming
in general.  The quality of the code wasn't great (it was in fact pretty
terrible), but since the assigment was interesting, I thought it would be fun
reimplement the project now that I have years of experience with Ruby.

You can find the assignment description at [INSTRUCTIONS.md](INSTRUCTIONS.md).

## What is this project not?

This project is not intended for general use.  I have no problem at all with you
using it to solve whatever problems you have that can be mapped to the traveling
salesman problem, but you will probably get better answers with a different library.
The various parameters of this program (population size, parents per generation,
children produced per generation, mutation length constraints, genetic segment
exchange lengths, etc.) were not chosen with any great degree of care — my work
has gone into the implementation, not parameter tuning.  It is likely further
experimentation with parameter tuning could result in faster convergence.

Performance was not an aim of this project, though of course I tried to avoid
needlessly expensive operations if a more performant alternative was not
significantly less obvious.

## Usage

### Setup

Run `bundle install` from the working directory.  This is only needed if you
intend to run the tests — the library itself uses only Ruby core and stdlib.

### Tests

You can run the test suite with `bin/rake` or `bin/rake spec`.
You can run an individual test file with e.g. `bin/rspec spec/foo_spec.rb`.

### Solving

You can run the algorithm with `bin/solve TSPDATA.txt 1000`, which will run
1000 generations with the city data in TSPDATA.txt.  It will print to stderr
a summary of each generation, where a line like `#45: 558711.57` means that
the best solution found in generation 45 is of length 558711.57.  At the end
of the run, it will print to stdout a list of city names separated by commas
(essentially a one-row CSV), which is the best solution found in the final
generation.

## Implementation Details

Each generation has 10 solutions in its population.

Only 2 solutions reproduce per generation.

These parents are each chosen as the result of a tournament between two randomly
selected solutions in the population.

The two parents will produce one child using partially mapped crossover
(see below) as the method of genetic exchange.

The child experiences random mutation (see below).

The next generation is identical to the previous generation, but with the weakest
solution replaced by the child.

### Genetic Exchange: Partially Mapped Crossover

Partially mapped crossover (PMX) between two parents *p1* and *p2* to produce a
child *c* works as follows.

```
p1: hiecgabfd
p2: iecgabfdh
```

Two crossover points are chosen at random (within constraints).  These points
define a segment that will cross over between the parents.

```
p1: hiec|gab|fd
p2: iecg|abf|dh
```

To make the child, first copy over the values from inside the segment in p1.

```
c: ____|gab|__
```

Then find all the values from inside the segment in *p1* that haven't yet been
copied into the child.  In this case, that's `f`, as `a` and `b` have already
been copied).

For each of these values, bounce from *p2* to *p1* by position (i.e. to the element
at the corresponding position in *p1*) and from *p1* to *p2* by value (i.e. to
the element in *p2* with the same value) until you land outside the crossover segment.
Fill in the value (the one from inside the segment in p2 that you began the bouncing
process with) at the corresponding position in *c*. In this case, `f` in *p2* is
located at the same position as `b` in *p1*, `b` in *p2* is located at the same
position as `a` in *p1*, and `a` in *p2* is located at the same position as `g` in
*p1*. `g` in *p2* is located outside of the crossover segment, so we put `f` (our
initial value) into this position of *c*.

```
c: ___f|gab|__
```

Finally, fill in the rest of the empty slots of *c* with the corresponding value from
*p2*.

```
c: iecf|gab|dh
```

The goal of PMX is to copy genetic material from one parent to the other. The
"bounce insert" part of the algorithm attempts to preserve order as much as possible
outside of this copied segment, but does some rearranging in order to avoid producing
invalid solutions (i.e., where some cities appear more than once and others not
at all).

### Mutation

Mutation on a solution is the reversal of a random (within constraints) segment.
For example, mutating `abcdefgh` might produce `abcgfedh`, where the `defg` segment
is reversed.

## Cheating Warning

It should go without saying that if you stumble across this project and it exactly
corresponds with a class assigment, making use of this code would qualify as
cheating.  I would suggest consulting with your instructor first before even
examining my implementation to ascertain whether making use of this code in such
a way falls within their expectations for your assigment.

## License

Released under the MIT license.  See [LICENSE.md](LICENSE.md) for details.
