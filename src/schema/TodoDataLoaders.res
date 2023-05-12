type listTodosArgs = {
  completed: option<bool>,
  filterText: option<string>,
}

type t = {
  byId: DataLoader.t<string, option<Todo.todo>>,
  list: DataLoader.t<listTodosArgs, array<Todo.todo>>,
}

let make = () => {
  byId: DataLoader.makeBatched(async todoIds => {
    let todos = await PretendDb.findManyTodos(~todoIds)
    todos->Array.map(todo => (todo :> option<Todo.todo>))
  }),
  list: DataLoader.makeSingle(async ({completed, filterText}) => {
    let filteredTodos = await PretendDb.findTodos(~filterText?, ~filterCompleted=?completed)
    filteredTodos->Array.map(todo => (todo :> Todo.todo))
  }),
}
