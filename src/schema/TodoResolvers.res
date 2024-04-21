open Todo

// TODO: This is ugly and we need a better solution for connections.
@module("resgraph/src/res/graphqlRelayConnections.mjs")
external connectionFromArray: (
  array<todo>,
  ~args: ResGraph.Connections.connectionArgs,
) => todoConnection = "connectionFromArray"

/** List todos. */
@gql.field
let listTodos = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~filterText,
  ~completed,
  ~first,
  ~after,
  ~before,
  ~last,
): option<todoConnection> => {
  let todos = await ctx.dataLoaders.todo.list->DataLoader.load({filterText, completed})
  todos->connectionFromArray(~args={first, after, before, last})->Some
}
