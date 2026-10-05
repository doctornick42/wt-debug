use("exampleDb");

db.users.drop();

db.users.insertMany([
    {
        _id: ObjectId("6836a11b9a95b3d064c59f35"),
        name: "Alice",
        email: "alice@example.com",
        age: 25
    },
    {
        _id: ObjectId("6836a11b9a95b3d064c59f36"),
        name: "Bob",
        email: "bob@example.com",
        age: 31
    },
    {
        _id: ObjectId("6836a11b9a95b3d064c59f37"),
        name: "Charlie",
        email: "charlie@example.com",
        age: 28
    }
]);

db.users.createIndex({
    email: 1
});

print("Initialization complete.");