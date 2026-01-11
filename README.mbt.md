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
2. **Simple query** - Running `SELECT version()`
3. **Parameterized queries** - Using `$1`, `$2` placeholders with proper parameter binding

## License

MIT
