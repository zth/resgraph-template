open Todo

/** Input for updating a todo. */
@gql.inputObject
type todoUpdateInput = {
  /** The id of the todo to update. */ todoId: ResGraph.id,
  /** Whether the todo is completed or not. */ completed: option<bool>,
  /** What text the todo has. */ text: option<string>,
}

@gql.union
type todoUpdateResult =
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
let todoUpdate = async (
  _: Schema.mutation,
  ~input: todoUpdateInput,
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
type todoDeleteResult =
  | Ok({deletedTodoId: ResGraph.id})
  | Error({reason: string})

/** Delete a todo. */
@gql.field
let todoDelete = async (_: Schema.mutation, ~todoId) => {
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
type todoAddResult = Ok({addedTodo: Todo.todo}) | Error({reason: string})

@gql.inputObject
type todoAddInput = {
  text: string,
  completed: bool,
}

/** Add a new Todo item. */
@gql.field
let todoAdd = async (_: Schema.mutation, ~input: todoAddInput) => {
  switch await PretendDb.addTodo(~text=input.text, ~completed=input.completed) {
  | Ok(addedTodo) => Ok({addedTodo: (addedTodo :> Todo.todo)})
  | Error() => Error({reason: "Could not add Todo."})
  }
}
