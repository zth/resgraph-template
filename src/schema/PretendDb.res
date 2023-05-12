// A pretend database for storing todos
type todo = {
  id: string,
  text: string,
  completed: bool,
}

type user = {
  id: string,
  name: string,
}

let todosIdSequence = ref(3)

let todos: array<todo> = [
  {id: "1", text: "Make the wise decision to start using ResGraph", completed: true},
  {id: "2", text: "Ship ResGraph to production", completed: false},
]

let users: array<user> = [{id: "1", name: "Test User"}]

let findSingleUser = async (~userId) => {
  users->Array.find(user => user.id === userId)
}

let findSingleTodo = async (~todoId) => {
  todos->Array.find(t => t.id === todoId)
}

let findManyTodos = async (~todoIds) => {
  await todoIds->Array.map(todoId => findSingleTodo(~todoId))->Promise.all
}

let filterOnText = (todo, filterText) => todo.text->String.startsWith(filterText)
let filterOnCompleted = (todo, completed) => todo.completed === completed

let findTodos = async (~filterText=?, ~filterCompleted=?) => {
  todos->Array.filter(todo => {
    switch (filterText, filterCompleted) {
    | (None, None) => true
    | (Some(filterText), None) => todo->filterOnText(filterText)
    | (None, Some(completedStatus)) => todo->filterOnCompleted(completedStatus)
    | (Some(filterText), Some(completedStatus)) =>
      todo->filterOnCompleted(completedStatus) && todo->filterOnText(filterText)
    }
  })
}

let addTodo = async (~text, ~completed): result<todo, unit> => {
  let id = todosIdSequence.contents->Int.toString
  todosIdSequence := todosIdSequence.contents + 1
  let newTodo = {id, text, completed}
  todos->Array.push(newTodo)
  Ok(newTodo)
}

let updateTodo = async (~todoId, ~updater) => {
  switch todos->Array.findIndexOpt(t => t.id === todoId) {
  | None => Error("Todo not found.")
  | Some(idx) =>
    let todo = todos->Array.getUnsafe(idx)
    let newTodo = updater(todo)
    todos[idx] = newTodo
    Ok(newTodo)
  }
}

let deleteTodo = async (~todoId) => {
  switch todos->Array.findIndexOpt(t => t.id === todoId) {
  | None => Error("Todo not found.")
  | Some(idx) =>
    todos->Array.spliceInPlace(~start=idx, ~remove=1, ~insert=[])
    Ok(todoId)
  }
}
