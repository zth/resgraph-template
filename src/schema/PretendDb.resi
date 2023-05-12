type todo = {id: string, text: string, completed: bool}
type user = {id: string, name: string}

let findSingleUser: (~userId: string) => promise<option<user>>
let findSingleTodo: (~todoId: string) => promise<option<todo>>
let findManyTodos: (~todoIds: array<string>) => promise<array<option<todo>>>
let findTodos: (~filterText: string=?, ~filterCompleted: bool=?) => promise<array<todo>>
let addTodo: (~text: string, ~completed: bool) => promise<result<todo, unit>>
let updateTodo: (~todoId: string, ~updater: todo => todo) => promise<result<todo, string>>
let deleteTodo: (~todoId: string) => promise<result<string, string>>
