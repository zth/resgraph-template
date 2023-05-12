@gql.type
type user = {
  ...NodeInterface.node,
  @gql.field name: string,
}
