type t = {byId: DataLoader.t<string, option<User.user>>}

let make = () => {
  byId: DataLoader.makeSingle(async userId => {
    switch await PretendDb.findSingleUser(~userId) {
    | None => None
    | Some(user) => Some((user :> User.user))
    }
  }),
}
