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
          println("Query result:")
          for row in result.rows() {
            println("  " + row[0])
          }
        }
        Err(e) => println("Query error: " + e.to_string())
      }

      // Example 2: Parameterized query with placeholders
      // PostgreSQL uses $1, $2, etc. for placeholders
      match conn.execute("SELECT $1::int as id", [42]) {
        Ok(result) => {
          defer result.free()
          println("Parameterized query result:")
          for row in result.rows() {
            println("  id: " + row[0])
          }
        }
        Err(e) => println("Execute error: " + e.to_string())
      }
      println("Connection closed")
    }
    Err(e) => println("Connection error: " + e.to_string())
  }
}
