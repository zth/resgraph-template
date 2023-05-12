@@warning("-27-32")

open ResGraph__GraphQLJs

let typeUnwrapper: 'src => 'return = %raw(`function typeUnwrapper(src) { if (src == null) return null; if (typeof src === 'object' && src.hasOwnProperty('_0')) return src['_0']; return src;}`)
type inputObjectFieldConverterFn
external makeInputObjectFieldConverterFn: ('a => 'b) => inputObjectFieldConverterFn = "%identity"

let applyConversionToInputObject: (
  'a,
  array<(string, inputObjectFieldConverterFn)>,
) => 'a = %raw(`function applyConversionToInputObject(obj, instructions) {
      if (instructions.length === 0) return obj;
      let newObj = Object.assign({}, obj);
      instructions.forEach(instruction => {
        let value = newObj[instruction[0]];
         newObj[instruction[0]] = instruction[1](value);
      })
      return newObj;
    }`)

let i_Node: ref<GraphQLInterfaceType.t> = Obj.magic({"contents": Js.null})
let get_Node = () => i_Node.contents
let t_AddTodoResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_AddTodoResultError = () => t_AddTodoResultError.contents
let t_AddTodoResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_AddTodoResultOk = () => t_AddTodoResultOk.contents
let t_DeleteTodoResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_DeleteTodoResultError = () => t_DeleteTodoResultError.contents
let t_DeleteTodoResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_DeleteTodoResultOk = () => t_DeleteTodoResultOk.contents
let t_UpdateTodoResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_UpdateTodoResultError = () => t_UpdateTodoResultError.contents
let t_UpdateTodoResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_UpdateTodoResultOk = () => t_UpdateTodoResultOk.contents
let t_Mutation: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Mutation = () => t_Mutation.contents
let t_PageInfo: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_PageInfo = () => t_PageInfo.contents
let t_Query: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Query = () => t_Query.contents
let t_Todo: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Todo = () => t_Todo.contents
let t_TodoConnection: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoConnection = () => t_TodoConnection.contents
let t_TodoEdge: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoEdge = () => t_TodoEdge.contents
let t_User: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_User = () => t_User.contents
let input_AddTodoInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_AddTodoInput = () => input_AddTodoInput.contents
let input_AddTodoInput_conversionInstructions = []
let input_UpdateTodoInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_UpdateTodoInput = () => input_UpdateTodoInput.contents
let input_UpdateTodoInput_conversionInstructions = []
input_AddTodoInput_conversionInstructions->Array.pushMany([])
input_UpdateTodoInput_conversionInstructions->Array.pushMany([
  ("completed", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("text", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
])
let union_AddTodoResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_AddTodoResult = () => union_AddTodoResult.contents
let union_DeleteTodoResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_DeleteTodoResult = () => union_DeleteTodoResult.contents
let union_UpdateTodoResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_UpdateTodoResult = () => union_UpdateTodoResult.contents

let union_AddTodoResult_resolveType = (v: TodoMutations.addTodoResult) =>
  switch v {
  | Ok(_) => "AddTodoResultOk"
  | Error(_) => "AddTodoResultError"
  }

let union_DeleteTodoResult_resolveType = (v: TodoMutations.deleteTodoResult) =>
  switch v {
  | Ok(_) => "DeleteTodoResultOk"
  | Error(_) => "DeleteTodoResultError"
  }

let union_UpdateTodoResult_resolveType = (v: TodoMutations.updateTodoResult) =>
  switch v {
  | Ok(_) => "UpdateTodoResultOk"
  | Error(_) => "UpdateTodoResultError"
  }

let interface_Node_resolveType = (v: ResGraphSchemaAssets.node_resolver) =>
  switch v {
  | Todo(_) => "Todo"
  | User(_) => "User"
  }

i_Node.contents = GraphQLInterfaceType.make({
  name: "Node",
  description: "An object with an ID.",
  interfaces: [],
  fields: () =>
    {
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
      },
    }->makeFields,
  resolveType: GraphQLInterfaceType.makeResolveInterfaceTypeFn(interface_Node_resolveType),
})
t_AddTodoResultError.contents = GraphQLObjectType.make({
  name: "AddTodoResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "reason": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_AddTodoResultOk.contents = GraphQLObjectType.make({
  name: "AddTodoResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "addedTodo": {
        typ: get_Todo()->GraphQLObjectType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["addedTodo"]
        }),
      },
    }->makeFields,
})
t_DeleteTodoResultError.contents = GraphQLObjectType.make({
  name: "DeleteTodoResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "reason": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_DeleteTodoResultOk.contents = GraphQLObjectType.make({
  name: "DeleteTodoResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "deletedTodoId": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["deletedTodoId"]
        }),
      },
    }->makeFields,
})
t_UpdateTodoResultError.contents = GraphQLObjectType.make({
  name: "UpdateTodoResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "message": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "What went wrong updating the todo.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["message"]
        }),
      },
    }->makeFields,
})
t_UpdateTodoResultOk.contents = GraphQLObjectType.make({
  name: "UpdateTodoResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "updatedTodo": {
        typ: get_Todo()->GraphQLObjectType.toGraphQLType->nonNull,
        description: "The todo that was updated.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["updatedTodo"]
        }),
      },
    }->makeFields,
})
t_Mutation.contents = GraphQLObjectType.make({
  name: "Mutation",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "addTodo": {
        typ: get_AddTodoResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: "Add a new Todo item.",
        deprecationReason: ?None,
        args: {
          "input": {typ: get_AddTodoInput()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          TodoMutations.addTodo(
            src,
            ~input=args["input"]->applyConversionToInputObject(
              input_AddTodoInput_conversionInstructions,
            ),
          )
        }),
      },
      "deleteTodo": {
        typ: get_DeleteTodoResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: "Delete a todo.",
        deprecationReason: ?None,
        args: {"todoId": {typ: Scalars.id->Scalars.toGraphQLType->nonNull}}->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          TodoMutations.deleteTodo(src, ~todoId=args["todoId"])
        }),
      },
      "updateTodo": {
        typ: get_UpdateTodoResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: "Update a todo.",
        deprecationReason: ?None,
        args: {
          "input": {typ: get_UpdateTodoInput()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          TodoMutations.updateTodo(
            src,
            ~ctx,
            ~input=args["input"]->applyConversionToInputObject(
              input_UpdateTodoInput_conversionInstructions,
            ),
          )
        }),
      },
    }->makeFields,
})
t_PageInfo.contents = GraphQLObjectType.make({
  name: "PageInfo",
  description: "Information about pagination in a connection.",
  interfaces: [],
  fields: () =>
    {
      "endCursor": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: "When paginating forwards, the cursor to continue.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["endCursor"]
        }),
      },
      "hasNextPage": {
        typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: "When paginating forwards, are there more items?",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["hasNextPage"]
        }),
      },
      "hasPreviousPage": {
        typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: "When paginating backwards, are there more items?",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["hasPreviousPage"]
        }),
      },
      "startCursor": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: "When paginating backwards, the cursor to continue.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["startCursor"]
        }),
      },
    }->makeFields,
})
t_Query.contents = GraphQLObjectType.make({
  name: "Query",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "currentTime": {
        typ: Scalars.float->Scalars.toGraphQLType,
        description: "The current time on the server, as a timestamp.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          Schema.currentTime(src)
        }),
      },
      "listTodos": {
        typ: get_TodoConnection()->GraphQLObjectType.toGraphQLType,
        description: "List todos.",
        deprecationReason: ?None,
        args: {
          "after": {typ: Scalars.string->Scalars.toGraphQLType},
          "before": {typ: Scalars.string->Scalars.toGraphQLType},
          "completed": {typ: Scalars.boolean->Scalars.toGraphQLType},
          "filterText": {typ: Scalars.string->Scalars.toGraphQLType},
          "first": {typ: Scalars.int->Scalars.toGraphQLType},
          "last": {typ: Scalars.int->Scalars.toGraphQLType},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          TodoResolvers.listTodos(
            src,
            ~after=args["after"]->Nullable.toOption,
            ~before=args["before"]->Nullable.toOption,
            ~completed=args["completed"]->Nullable.toOption,
            ~ctx,
            ~filterText=args["filterText"]->Nullable.toOption,
            ~first=args["first"]->Nullable.toOption,
            ~last=args["last"]->Nullable.toOption,
          )
        }),
      },
      "me": {
        typ: get_User()->GraphQLObjectType.toGraphQLType->nonNull,
        description: "The currently logged in user.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          UserResolvers.me(src, ~ctx)
        }),
      },
      "node": {
        typ: get_Node()->GraphQLInterfaceType.toGraphQLType,
        description: "Fetches an object given its ID.",
        deprecationReason: ?None,
        args: {"id": {typ: Scalars.id->Scalars.toGraphQLType->nonNull}}->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.node(src, ~ctx, ~id=args["id"])
        }),
      },
      "nodes": {
        typ: GraphQLListType.make(get_Node()->GraphQLInterfaceType.toGraphQLType)
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: "Fetches objects given their IDs.",
        deprecationReason: ?None,
        args: {
          "ids": {
            typ: GraphQLListType.make(Scalars.id->Scalars.toGraphQLType->nonNull)
            ->GraphQLListType.toGraphQLType
            ->nonNull,
          },
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.nodes(src, ~ctx, ~ids=args["ids"])
        }),
      },
    }->makeFields,
})
t_Todo.contents = GraphQLObjectType.make({
  name: "Todo",
  description: "A single todo item.",
  interfaces: [get_Node()],
  fields: () =>
    {
      "completed": {
        typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: "Whether the todo is completed or not.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["completed"]
        }),
      },
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.id(src, ~typename=Todo)
        }),
      },
      "text": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The text of the todo item.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["text"]
        }),
      },
    }->makeFields,
})
t_TodoConnection.contents = GraphQLObjectType.make({
  name: "TodoConnection",
  description: "A connection to a todo.",
  interfaces: [],
  fields: () =>
    {
      "edges": {
        typ: GraphQLListType.make(
          get_TodoEdge()->GraphQLObjectType.toGraphQLType,
        )->GraphQLListType.toGraphQLType,
        description: "A list of edges.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["edges"]
        }),
      },
      "pageInfo": {
        typ: get_PageInfo()->GraphQLObjectType.toGraphQLType->nonNull,
        description: "Information to aid in pagination.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["pageInfo"]
        }),
      },
    }->makeFields,
})
t_TodoEdge.contents = GraphQLObjectType.make({
  name: "TodoEdge",
  description: "An edge to a todo.",
  interfaces: [],
  fields: () =>
    {
      "cursor": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "A cursor for use in pagination.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["cursor"]
        }),
      },
      "node": {
        typ: get_Todo()->GraphQLObjectType.toGraphQLType,
        description: "The item at the end of the edge.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["node"]
        }),
      },
    }->makeFields,
})
t_User.contents = GraphQLObjectType.make({
  name: "User",
  description: ?None,
  interfaces: [get_Node()],
  fields: () =>
    {
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.id(src, ~typename=User)
        }),
      },
      "name": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx) => {
          let src = typeUnwrapper(src)
          src["name"]
        }),
      },
    }->makeFields,
})
input_AddTodoInput.contents = GraphQLInputObjectType.make({
  name: "AddTodoInput",
  description: ?None,
  fields: () =>
    {
      "completed": {
        GraphQLInputObjectType.typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
      },
      "text": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_UpdateTodoInput.contents = GraphQLInputObjectType.make({
  name: "UpdateTodoInput",
  description: "Input for updating a todo.",
  fields: () =>
    {
      "completed": {
        GraphQLInputObjectType.typ: Scalars.boolean->Scalars.toGraphQLType,
        description: "Whether the todo is completed or not.",
        deprecationReason: ?None,
      },
      "text": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType,
        description: "What text the todo has.",
        deprecationReason: ?None,
      },
      "todoId": {
        GraphQLInputObjectType.typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the todo to update.",
        deprecationReason: ?None,
      },
    }->makeFields,
})
union_AddTodoResult.contents = GraphQLUnionType.make({
  name: "AddTodoResult",
  description: ?None,
  types: () => [get_AddTodoResultError(), get_AddTodoResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_AddTodoResult_resolveType),
})
union_DeleteTodoResult.contents = GraphQLUnionType.make({
  name: "DeleteTodoResult",
  description: ?None,
  types: () => [get_DeleteTodoResultError(), get_DeleteTodoResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_DeleteTodoResult_resolveType),
})
union_UpdateTodoResult.contents = GraphQLUnionType.make({
  name: "UpdateTodoResult",
  description: ?None,
  types: () => [get_UpdateTodoResultError(), get_UpdateTodoResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_UpdateTodoResult_resolveType),
})

let schema = GraphQLSchemaType.make({"query": get_Query(), "mutation": get_Mutation()})
