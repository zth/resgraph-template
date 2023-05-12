/** A single todo item. */
@gql.type
type todo = {
  ...NodeInterface.node,
  /** The text of the todo item. */
  @gql.field
  text: string,
  /** Whether the todo is completed or not. */
  @gql.field
  completed: bool,
}

/** An edge to a todo. */
@gql.type
type todoEdge = ResGraph.Connections.edge<todo>

/** A connection to a todo. */
@gql.type
type todoConnection = ResGraph.Connections.connection<todoEdge>
