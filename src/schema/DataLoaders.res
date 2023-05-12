type t = {
  user: UserDataLoaders.t,
  todo: TodoDataLoaders.t,
}

let make = () => {
  user: UserDataLoaders.make(),
  todo: TodoDataLoaders.make(),
}
