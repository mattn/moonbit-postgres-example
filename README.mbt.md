# MoonBit PostgreSQL Example

A sample project demonstrating how to use PostgreSQL with MoonBit.

## Overview

This example shows how to:
- Connect to a PostgreSQL database
- Execute simple queries
- Use parameterized queries
- Handle errors

## Prerequisites

- MoonBit compiler
- PostgreSQL server running
- `libpq` development libraries (on some systems)

**Note**: This project only supports the `native` target because it uses PostgreSQL's libpq C library. You must always specify `--target native` when building, checking, or testing.

## Setup

1. Set the database connection URL:

```bash
export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
```

2. Build the project as a native executable:

```bash
moon build --target native
```

3. Run the compiled binary:

```bash
./target/native/release/main
```

## Project Structure

- `cmd/main/` - Main executable that demonstrates PostgreSQL operations
- `example.mbt` - Sample MoonBit functions for reference
- `lib/` - Library code (if any)

## Example Code

The main program demonstrates:

1. **Connecting to PostgreSQL** using environment variables
2. **Simple query** - Running `SELECT version()` and iterating over result rows
3. **Parameterized queries** - Using `$1`, `$2` placeholders with proper parameter binding and result iteration

## Working with Query Results

Results from queries return rows as `Array[Array[String]]`. To process results:

```moonbit
for row in result.rows() {
  // row is Array[String] - each element is a column value
  println(row.to_string())
}
```

This allows you to handle multiple rows returned from a query.

## Parameter Values

When executing parameterized queries, use helper functions to construct parameter values:

```moonbit
conn.execute("SELECT * FROM users WHERE id = $1 AND name = $2", [
  @postgres.from_int(42),
  @postgres.from_string("Alice")
])
```

Available helper functions:
- `from_int(value : Int) -> Value`
- `from_string(value : String) -> Value`
- `from_bool(value : Bool) -> Value`

Note: The `Value` type constructors (e.g., `Value::Int(42)`) are not publicly exposed; use the helper functions instead.

## License

MIT
