module hashset;

import std.container.array;

struct HashSet(T) {
protected:

    bool[T] data;

public:

    /// Condense a HashSet from items.
    /// Params:
    ///   initialData = The initial data to add. Duplicates will condense.
    this(T...)(T initialData) {
        foreach (value; initialData) {
            data[value] = true;
        }
    }

    /// Construct a HashSet from array.
    /// Params:
    ///   initialData = The initial data array to add. Duplicates will condense.
    this(T[] initialData) {
        foreach (value; initialData) {
            data[value] = true;
        }
    }

    /// Construct a HashSet from another HashSet.
    /// Params:
    ///   initialData = The initial data from another HashSet to add.
    this(HashSet!T initialData) {
        foreach (value, _; initialData.data) {
            data[value] = true;
        }
    }

    /// Add items to the HashSet.
    /// Params:
    ///   newData = New data to add. Duplicates will condense.
    void insert(T...)(T newData) {
        foreach (value; newData) {
            data[value] = true;
        }
    }

    /// Add items from an array to the HashSet.
    /// Params:
    ///   newData = The array to add. Duplicates will condense.
    void insert(T[] newData) {
        foreach (value; newData) {
            data[value] = true;
        }
    }

    /// Inserts the items from another HashSet into this HashSet.
    /// Params:
    ///   otherHashSet = The other HashSet to add from.
    void insert(HashSet!T otherHashSet) {
        foreach (value, _; otherHashSet.data) {
            data[value] = true;
        }
    }

    /// Erase items from the HashSet.
    /// Params:
    ///   toErase = Data to erase.
    void erase(T...)(T toErase) {
        foreach (value; toErase) {
            data.remove(value);
        }
    }

    /// Erase items from the HashSet using an array..
    /// Params:
    ///   toErase = Array data to erase.
    void erase(T[] toErase) {
        foreach (value; toErase) {
            data.remove(value);
        }
    }

    /// Erase items from this HashSet using values from another.
    /// Params:
    ///   otherHashSet = The other HashSet which contains the items to remove.
    void erase(HashSet!T otherHashSet) {
        foreach (value, _; otherHashSet.data) {
            data.remove(value);
        }
    }

    /// Check if contains all data. If multiple, one item missing == false.
    /// Params:
    ///   dataCheck = Data to check for.
    /// Returns: If contains all data.
    bool contains(T...)(T dataCheck) {
        // Cannot contain nothing.
        if (dataCheck.length == 0) {
            return false;
        }
        foreach (value; dataCheck) {
            if (value !in data) {
                return false;
            }
        }
        return true;
    }

    /// Check if contains all data from array. One item missing == false.
    /// Params:
    ///   dataCheck = Array of data to check for.
    /// Returns: If contains all data.
    bool contains(T[] dataCheck) {
        // Cannot contain nothing.
        if (dataCheck.length == 0) {
            return false;
        }
        foreach (value; dataCheck) {
            if (value !in data) {
                return false;
            }
        }
        return true;
    }

    /// Check if contains all data from another HashSet. One item missing == false.
    /// Params:
    ///   dataCheck = Other HashSet containing data to check for.
    /// Returns: If contains all data.
    bool contains(HashSet!T dataCheck) {
        // Cannot contain nothing.
        if (dataCheck.length() == 0) {
            return false;
        }
        foreach (value, _; dataCheck.data) {
            if (value !in data) {
                return false;
            }
        }
        return true;
    }

    /// Combines this HashSet with another. Creates new HashSet.
    /// Params:
    ///   otherHashSet = The other HashSet to merge with.
    /// Returns: A new HashSet containing both HashSet's data.
    HashSet!T merge(HashSet!T otherHashSet) {
        HashSet!T newHashSet;
        newHashSet.insert(this);
        newHashSet.insert(otherHashSet);
        return newHashSet;
    }

    /// Clear the HashSet.
    void clear() {
        data.clear();
    }

    /// Swap data with another HashSet.
    /// Params:
    ///   other = Another HashSet to swap data with.
    void swap(ref HashSet!T other) {
        bool[T] thisOldData = data;
        data = other.data;
        other.data = thisOldData;
    }

    /// Check if the HashSet is empty.
    bool empty() {
        return data.length == 0;
    }

    /// Get the number of items in the HashSet.
    ulong length() {
        return data.length;
    }

    // Get all the data from the HashSet into a standard array.
    T[] intoArray() {
        return data.keys;
    }

    /// This is literally so you can foreach over the HashSet.
    int opApply(scope int delegate(ref T) dg) {
        int result = 0;

        foreach (value, _; data) {
            result = dg(value);
            if (result)
                break;
        }

        return result;
    }
}

unittest {
    import std.stdio;

    auto neat = HashSet!int(1, 2, 3, 4, 5).merge(HashSet!int(6, 7, 8, 9, 10));

    writeln(neat);
    assert(neat.contains(1, 2, 3, 4, 5, 6, 7, 8, 9, 10));

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
