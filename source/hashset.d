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
