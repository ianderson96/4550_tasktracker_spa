# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TasktrackerSpa.Repo.insert!(%TasktrackerSpa.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TasktrackerSpa.Repo
alias TasktrackerSpa.Users.User

pwhash = Argon2.hash_pwd_salt("pass1")

Repo.insert!(%User{email: "alice@example.com", admin: true, password_hash: pwhash})
Repo.insert!(%User{email: "bob@example.com", admin: false, password_hash: pwhash})

alias TasktrackerSpa.Tasks.Task

Repo.insert!(%Task{
  title: "Do web dev homework",
  desc: "build single page application task tracker",
  minutes: 0,
  completed: false
})

Repo.insert!(%Task{
  title: "Final paper outline",
  desc: "update thesis",
  minutes: 0,
  completed: false
})
