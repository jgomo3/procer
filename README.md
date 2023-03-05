# Procer

**NOTE: Experimental. Use it to experience what a default `to_proc`
could have been. For production code, I recommend an explicit
transformation, like the one provided by the gem `jgomo3-func`**.

A reasonable good default `to_proc` method for all objects.

Install with:

```
gem install procer
```

When you require Procer, all objects will have a default `to_proc`
method which will try to call one of the following methods, in the
given order:

 - `call`
 - `[]`
 - `===`
 
 Many methods which receive a block, can benefit greatly from this
 because you can now pass an object to perform the block role.
 
 Think of the Enumerable module and all its methods.
 
 Many objects define `===`, but not `to_proc`. So they will be nicely
 usable in a `case/when` expression, but not in other contexts.
 
 This is the case of classes and ranges, which you can use in
 `case/when` expressions, but they don't define `to_proc`.
 
 Now they do define `to_proc` so they are useful in those contexts.
 
 Examples:
 
 ```ruby
 require 'procer'
 
[1, 2, '3', '4', 5, 6].filter(&Numeric)
# => [1, 2, 5, 6]

[-10, 100, -2, 3, 20, -33].filter(&(0..50))
# => [3, 20]
```

Also, Hashes already implement `to_proc` and that is useful
with Enumerator. We can use it as a transformation table with `map`:

```ruby

table = {
  1 => 'one',
  2 => 'two',
  3 => 'three'
}

[3, 1, 2].map(&table)
# => ['three, 'one, 'two']
```

Sadly, Arrays, even when they have the same interface as hashes as a
function of indices, don't implement `to_proc` and so they can't be used
in the same way. Until now.

```ruby
table = ['zero', 'one', 'two']
[2, 0, 1].map(&table)
# => ['two', 'zero', 'one']
```

Alternatively, you could have used `values_at`:

```ruby
table.values_at([3, 1, 2]) # In the Hash example
table.values_at([2, 0, 1]) # In the Array example
```

But the map solution is more generic and `table` can be anything that
implements `to_proc` and not something that necessarily implements
`values_at`.

Notice that if the object implements `[]` that will triumph over
`===`.  It was unexpected when I tried to use Integers as the object, as
they implement `[]` as a way to access their binary form:

```ruby
5 # b101
[5[2], 5[1], 5[0]] # [1, 0, 1]
```

So the proc will work like that:

```ruby
[2, 4, 5].map(&5)
# Actual => [1, 0, 0]
# I was expecting => [false, false, true]
```
