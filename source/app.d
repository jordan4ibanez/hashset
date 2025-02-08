import std.stdio;

import hashset;

void main() {
	HashSet!int blah = HashSet!int([1, 4, 4, 234,]);

	blah.erase(1, 4, 234);

	writeln(blah);

	blah.insert(1, 2, 3, 4, 5);

	auto foof = HashSet!int(6, 7, 8, 9, 10);

	blah.insert(foof);

	writeln(blah);

	writeln(blah.merge(HashSet!int(11, 12, 13, 14, 15)));

	foreach (k; blah) {
		writeln(k);
	}

	writeln(blah.contains(HashSet!int(1,2,3)));


}
