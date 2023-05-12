@gql.type
type query

@gql.type
type mutation

/** The current time on the server, as a timestamp. */
@gql.field
let currentTime = (_: query) => {
  Some(Date.now())
}
