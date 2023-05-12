open Todo

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
  todos->ResGraph.Connections.connectionFromArray(~args={first, after, before, last})->Some
}
