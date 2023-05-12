/** The currently logged in user. */
@gql.field
let me = async (_: Schema.query, ~ctx: ResGraphContext.context) => {
  switch ctx.currentUserId {
  | None => panic("No logged in user.")
  | Some(userId) =>
    switch await ctx.dataLoaders.user.byId->DataLoader.load(userId) {
    | None => panic("Did not find logged in user.")
    | Some(user) => user
    }
  }
}
