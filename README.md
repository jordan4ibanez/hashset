# hashset
 Hashset for D.

You just use it like you would think you use a HashSet.

How to use:
```D

import std.stdio;

import hashset;

void main() {
	HashSet!int myCoolHashSet = HashSet!int([1, 4, 4, 234,]);

	myCoolHashSet.erase(1, 4, 234);

	myCoolHashSet.insert([1, 2, 3, 4]);

	myCoolHashSet.insert(HashSet!int(5, 6, 7, 8, 74, 3, 6, 1, 23, 3));

	writeln(myCoolHashSet);

	myCoolHashSet.insert(1, 2, 3, 4, 5);

	auto blah = HashSet!int(6, 7, 8, 9, 10);

	myCoolHashSet.insert(blah);

	writeln(myCoolHashSet);

	writeln(myCoolHashSet.merge(HashSet!int(11, 12, 13, 14, 15)));

	foreach (k; myCoolHashSet) {
		writeln(k);
	}

	writeln(myCoolHashSet.contains(HashSet!int(1, 2, 3)));

	myCoolHashSet.clear();

	writeln(myCoolHashSet.empty());

	writeln(HashSet!int().empty());

	writeln("=-=-=-=-==--==");

	{
		auto a = HashSet!string("one", "two", "three");
		auto b = HashSet!string("four", "five", "six");

		a.swap(b);

		writeln(a);
		writeln(b);
	}

    {
        auto tempTestCase = HashSet!int(1,2,3,4,5).merge(HashSet!int(6, 7, 8, 9, 10));

        assert(tempTestCase.contains(1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
    }
}
```

If you are still confused, please see the source code or unit test.