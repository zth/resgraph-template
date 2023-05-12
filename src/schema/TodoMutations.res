open Todo

/** Input for updating a todo. */
@gql.inputObject
type updateTodoInput = {
  /** The id of the todo to update. */ todoId: ResGraph.id,
  /** Whether the todo is completed or not. */ completed: option<bool>,
  /** What text the todo has. */ text: option<string>,
}

@gql.union
type updateTodoResult =
  | Ok({
      /** The todo that was updated. */
      updatedTodo: todo,
    })
  | Error({
      /** What went wrong updating the todo. */
      message: string,
    })

/** Update a todo. */
@gql.field
let updateTodo = async (
  _: Schema.mutation,
  ~input: updateTodoInput,
  ~ctx: ResGraphContext.context,
) => {
  let todoId = input.todoId->NodeInterfaceResolver.dbIdForType(Todo)

  switch (todoId, ctx.currentUserId) {
  | (None, _) => Error({message: "Invalid todo id."})
  | (_, None) => Error({message: "You need to be logged in to update todo's."})
  | (Some(todoId), Some(_currentUserId)) =>
    switch await PretendDb.updateTodo(~todoId, ~updater=todo => {
      ...todo,
      completed: input.completed->Option.getWithDefault(todo.completed),
      text: input.text->Option.getWithDefault(todo.text),
    }) {
    | Ok(newTodo) => Ok({updatedTodo: (newTodo :> Todo.todo)})
    | Error(reason) => Error({message: reason})
    }
  }
}

@gql.union
type deleteTodoResult =
  | Ok({deletedTodoId: ResGraph.id})
  | Error({reason: string})

/** Delete a todo. */
@gql.field
let deleteTodo = async (_: Schema.mutation, ~todoId) => {
  let todoDbId = todoId->NodeInterfaceResolver.dbIdForType(Todo)

  switch todoDbId {
  | None => Error({reason: "Invalid ID for Todo."})
  | Some(todoDbId) =>
    switch await PretendDb.deleteTodo(~todoId=todoDbId) {
    | Ok(_) => Ok({deletedTodoId: todoId})
    | Error(msg) => Error({reason: msg})
    }
  }
}

@gql.union
type addTodoResult = Ok({addedTodo: Todo.todo}) | Error({reason: string})

@gql.inputObject
type addTodoInput = {
  text: string,
  completed: bool,
}

/** Add a new Todo item. */
@gql.field
let addTodo = async (_: Schema.mutation, ~input: addTodoInput) => {
  switch await PretendDb.addTodo(~text=input.text, ~completed=input.completed) {
  | Ok(addedTodo) => Ok({addedTodo: (addedTodo :> Todo.todo)})
  | Error() => Error({reason: "Could not add Todo."})
  }
}
