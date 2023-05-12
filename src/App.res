open GraphQLYoga

let yoga = createYoga({
  schema: ResGraphSchema.schema,
  context: async ({request}) => {
    {
      ResGraphContext.currentUserId: request->Request.headers->Headers.get("x-user-id"),
      dataLoaders: DataLoaders.make(),
    }
  },
})

let server = NodeHttpServer.createServer(yoga)

server->NodeHttpServer.listen(9797, () => {
  Console.info("Server is running on http://localhost:9797/graphql")
})
