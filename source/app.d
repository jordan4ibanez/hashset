import std.stdio;

import hashset;

void main() {
	HashSet!int myCoolHashSet = HashSet!int([1, 4, 4, 234,]);

	myCoolHashSet.erase(1, 4, 234);

	myCoolHashSet.insert([1, 2, 3, 4]);

	myCoolHashSet.insert(HashSet!int(5, 6, 7, 8, 74, 3, 6, 1, 23, 3));

	writeln(myCoolHashSet);

	myCoolHashSet.insert(1, 2, 3, 4, 5);

	auto foof = HashSet!int(6, 7, 8, 9, 10);

	myCoolHashSet.insert(foof);

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

	// Serious time.
	writeln(":::::SERIOUS TIME:::::");

	auto testCase = HashSet!int(1, 2, 3, 4, 5);
	assert(testCase.contains(1, 2, 3, 4, 5));
	assert(testCase.contains([1, 2, 3, 4, 5]));
	assert(testCase.contains(HashSet!int(1, 2, 3, 4, 5)));

	assert(!testCase.contains(-1, 2, 10, 9));
	assert(!testCase.contains([-1, 2, 10, 9]));
	assert(!testCase.contains(HashSet!int(-1, 2, 10, 9)));
	assert(!testCase.contains());

	writeln("Passed contains 1");

	testCase = HashSet!int([1, 2, 3, 4, 5]);

	assert(testCase.contains(1, 2, 3, 4, 5));
	assert(testCase.contains([1, 2, 3, 4, 5]));
	assert(testCase.contains(HashSet!int(1, 2, 3, 4, 5)));

	assert(!testCase.contains(-1, 2, 10, 9));
	assert(!testCase.contains([-1, 2, 10, 9]));
	assert(!testCase.contains(HashSet!int(-1, 2, 10, 9)));
	assert(!testCase.contains());

	writeln("Passed contains 2");

	testCase = HashSet!int(HashSet!int(1, 2, 3, 4, 5));

	assert(testCase.contains(1, 2, 3, 4, 5));
	assert(testCase.contains([1, 2, 3, 4, 5]));
	assert(testCase.contains(HashSet!int(1, 2, 3, 4, 5)));

	assert(!testCase.contains(-1, 2, 10, 9));
	assert(!testCase.contains([-1, 2, 10, 9]));
	assert(!testCase.contains(HashSet!int(-1, 2, 10, 9)));
	assert(!testCase.contains());

	writeln("Passed contains 3");

	{
		auto tempTestCase = testCase.merge(HashSet!int(6, 7, 8, 9, 10));

		assert(tempTestCase.contains(1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
		assert(tempTestCase.contains([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));
		assert(tempTestCase.contains(HashSet!int(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)));

		assert(!tempTestCase.contains(-1, 2, 10, 9));
		assert(!tempTestCase.contains([-1, 2, 10, 9]));
		assert(!tempTestCase.contains(HashSet!int(-1, 2, 10, 9)));
		assert(!tempTestCase.contains());
	}

	writeln("Passed merge");

	testCase = HashSet!int(1, 2, 3, 4, 5);
	testCase.erase(2, 4);

	assert(testCase.contains(1, 3, 5));
	assert(testCase.contains([1, 3, 5]));
	assert(testCase.contains(HashSet!int(1, 3, 5)));

	assert(!testCase.contains(1, 2, 3, 4, 5));
	assert(!testCase.contains([1, 2, 3, 4, 5]));
	assert(!testCase.contains(HashSet!int(1, 2, 3, 4, 5)));
	assert(!testCase.contains());

	writeln("Passed erase 1");

	testCase = HashSet!int(1, 2, 3, 4, 5);
	testCase.erase([2, 4]);

	assert(testCase.contains(1, 3, 5));
	assert(testCase.contains([1, 3, 5]));
	assert(testCase.contains(HashSet!int(1, 3, 5)));

	assert(!testCase.contains(1, 2, 3, 4, 5));
	assert(!testCase.contains([1, 2, 3, 4, 5]));
	assert(!testCase.contains(HashSet!int(1, 2, 3, 4, 5)));
	assert(!testCase.contains());

	writeln("Passed erase 2");

	testCase = HashSet!int(1, 2, 3, 4, 5);
	testCase.erase(HashSet!int(2, 4));

	assert(testCase.contains(1, 3, 5));
	assert(testCase.contains([1, 3, 5]));
	assert(testCase.contains(HashSet!int(1, 3, 5)));

	assert(!testCase.contains(1, 2, 3, 4, 5));
	assert(!testCase.contains([1, 2, 3, 4, 5]));
	assert(!testCase.contains(HashSet!int(1, 2, 3, 4, 5)));
	assert(!testCase.contains());

	writeln("Passed erase 3");

	assert(testCase.length() == 3);
	assert(testCase.length() > 0);
	assert(!testCase.empty());

	testCase.clear();

	assert(testCase.length() == 0);
	assert(testCase.empty());

	writeln("Passed clear");
	writeln("Passed length");
	writeln("Passed empty");

	{
		auto a = HashSet!int(1, 2, 3);
		auto b = HashSet!int(4, 5, 6);

		a.swap(b);

		assert(a.contains(4, 5, 6));
		assert(b.contains(1, 2, 3));
	}

	writeln("Passed swap");

	testCase = HashSet!int(1, 2, 3, 4, 5);

	{
		auto output = HashSet!int();
		int[] outputArray = [];

		assert(output.empty);

		foreach (value; testCase) {
			output.insert(value);
			outputArray ~= value;
		}

		assert(output.contains(1, 2, 3, 4, 5));

		foreach (searchTerm; [1, 2, 3, 4, 5]) {
			bool found = false;
			inner: foreach (int key; outputArray) {
				if (key == searchTerm) {
					found = true;
					break inner;
				}
			}
			assert(found);
		}

	}

	writeln("Passed opApply");

}
