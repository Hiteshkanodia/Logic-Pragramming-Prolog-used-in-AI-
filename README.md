
Problem Statement :-

Consider a programming language that supports the following five kinds of statements:
- alloc(a, o) allocates an object `o` on the heap and stores its reference into the variable `a`
- copy(a, b) copies the object pointed-to by `b` to `a`
- load(a, b, f) loads the object pointed-to by `b.f` and copies it to `a`
- store(a, f, b) stores the object pointed-to by `b` into `a.f`
- invoke(m, l) passes the variables in the list `l` to the method `m`

In this language, an object escapes if it is reachable from any of the arguments passed to `m`.
For example, consider this program:


```
alloc(a, o1)
alloc(b, o2)
alloc(c, o3)
store(a, f, c)
load(d, a, f)
invoke(m1, [a])
```

Here, `a` points to `o1`, `b` points to `o2`, `c` points to `o3`, `a.f` points to `o3`, and `d` points to `o3`. As `a` is passed to `m1`, objects `o1` and `o3` escape, and `o2` does not escape.

In this we have to implement an escape analysis in Prolog.
In particular, we should be able to answer the following queries:
- escapes(o) should return `true` or `false`, indicating whether the object `o` escapes or not.
- escapesthrough(o, m) should return `true` or `false`, indicating whether the object `o` escapes through method `m`.
- allescapes(m, L) should return a list of `L` of all the objects that escape through the method `m`.

The input will be programs represented as Prolog facts of the above form (alloc, copy, load, store and invoke).

