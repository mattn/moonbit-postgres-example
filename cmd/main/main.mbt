///|
fn main {
  // Get connection string from environment variable DATABASE_URL
  let conn_url = @postgres.pg_get_env("DATABASE_URL")
  println("Connection URL: " + conn_url)
  
  match @postgres.connect(conn_url) {
    Ok(conn) => {
      defer conn.close()
      println("Connected to PostgreSQL")

      // Example 1: Simple query
      match conn.query("SELECT version()") {
        Ok(result) => {
          defer result.free()
          let rows = result.rows()
          println("Query result:")
          rows.iter(fn(row) {
            println("  " + row.to_string())
          })
        }
        Err(e) => println("Query error: " + @postgres.PgError::to_string(e))
      }

      // Example 2: Parameterized query with placeholders
      // PostgreSQL uses $1, $2, etc. for placeholders
      match conn.execute("SELECT $1::int as id, $2::text as name", [
        @postgres.from_int(42),
        @postgres.from_string("Alice")
      ]) {
        Ok(result) => {
          defer result.free()
          let rows = result.rows()
          println("Parameterized query result:")
          rows.iter(fn(row) {
            println("  " + row.to_string())
          })
        }
        Err(e) => println("Execute error: " + @postgres.PgError::to_string(e))
      }

      println("Connection closed")
    }
    Err(e) => {
      println("Connection error: " + @postgres.PgError::to_string(e))
    }
  }
}
