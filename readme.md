## yield_from: implementing `yield from func()` functionality by modifying `yield *func()` behavior

### Usage

```
require 'yield_from'
class A
    extend YieldFrom
    def rec(n)
		return to_enum(:rec,n) if !block_given?
        return if n<0
		yield n
    	yield *rec(n-1)
    end
    rec = yield_from(:rec)
end
p A.new.rec(5).to_a # => [5, 4, 3, 2, 1, 0]
```

There are instance method version and local function version.

### Motivation

In the above example, similar code was running until **Ruby 2.7** .

```
class A
    def rec(n)
		return to_enum(:rec,n) if !block_given?
        return if n<0
		yield n
    	rec(n-1, &proc)
    end
end
p A.new.rec(5).to_a # => [5, 4, 3, 2, 1, 0]
```

**The bare proc got forbidden in Ruby 3.0.**

You can see the discussion at https://qiita.com/cielavenir/items/0cc9189f2c40d6047d8b .

### Acknowledgement

Learned Ruby decorator from Nakayama R et al. Automatic Translation of Decorators from Python to Ruby, The 77th National Convention of IPSJ, 2015
