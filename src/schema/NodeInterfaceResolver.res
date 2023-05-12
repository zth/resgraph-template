open ResGraphSchemaAssets

/** Type map holding a mapping from type name to its compressed value. Keep
  adding to this as you implement the node interface for more types.
  Remember that all ints should be unique in the type map, and you should
  preferably never re-use the same int twice even if you remove types. */
let typeMap: node_typeMap<int> = {
  user: 1,
  todo: 2,
}

/** A typemap helping us produce compressed node IDs via the map defined above. */
let nodeTypeMap = NodeInterfaceTypeMap.make(typeMap, ~valueToString=Int.toString)

let decodeNodeInterfaceId = id => {
  switch id->ResGraph.idToString->ResGraph.Utils.Base64.decode->String.split(":")->List.fromArray {
  | list{typeValue, id, ...params} =>
    switch nodeTypeMap->NodeInterfaceTypeMap.getTypeByStringifiedValue(typeValue) {
    | None => None
    | Some(typ) => Some(typ, id, params->List.toArray)
    }
  | _ => None
  }
}

/** Tries to extract a database ID from a specific node GraphQL type. */
let dbIdForType = (id, typ) =>
  switch decodeNodeInterfaceId(id) {
  | Some(t, id, _) if t === typ => Some(id)
  | _ => None
  }

let nodeInterfaceIdToString = (~typename: node_implementedBy, ~id, ~extra=[]) => {
  let value = nodeTypeMap->NodeInterfaceTypeMap.getStringifiedValueByType(typename)
  let nodeId = [value, id]->Array.concat(extra)->Array.joinWith(":")

  nodeId->ResGraph.Utils.Base64.encode->ResGraph.id
}

/** Fetches an object given its ID. */
@gql.field
let node = async (_: Schema.query, ~id, ~ctx: ResGraphContext.context): option<node_resolver> => {
  switch decodeNodeInterfaceId(id) {
  | None => None
  | Some(typename, id, _extraParams) =>
    switch typename {
    | User =>
      switch await ctx.dataLoaders.user.byId->DataLoader.load(id) {
      | None => None
      | Some(user) => Some(User(user))
      }
    | Todo =>
      switch await ctx.dataLoaders.todo.byId->DataLoader.load(id) {
      | None => None
      | Some(todo) => Some(Todo(todo))
      }
    }
  }
}

/** Fetches objects given their IDs. */
@gql.field
let nodes = (query: Schema.query, ~ids, ~ctx: ResGraphContext.context) => {
  ids->Array.map(id => node(query, ~id, ~ctx))
}

/** The id of the object. */
@gql.field
let id = (node: NodeInterface.node, ~typename: node_implementedBy) => {
  nodeInterfaceIdToString(~typename, ~id=node.id)
}
