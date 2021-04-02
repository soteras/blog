alias Blog.Auth.Users
alias Blog.Content.Contents

{:ok, user1} =
  Users.create(%{
    name: "User 1",
    email: "user1@gmail.com",
    password: "abc12345",
    password_confirmation: "abc12345"
  })

{:ok, user2} =
  Users.create(%{
    name: "User 2",
    email: "user2@gmail.com",
    password: "abc12345",
    password_confirmation: "abc12345"
  })

{:ok, post1} = Contents.create_post(%{message: "Post 1", user_id: user1.id})
{:ok, post2} = Contents.create_post(%{message: "Post 2", user_id: user2.id})

{:ok, comment1} =
  Contents.create_comment(%{post_id: post1.id, user_id: user1.id, message: "Very Nice"})

{:ok, _} = Contents.create_comment(%{post_id: post1.id, user_id: user1.id, message: "It's ok"})

{:ok, comment3} =
  Contents.create_comment(%{post_id: post2.id, user_id: user1.id, message: "Noooo!!!"})

{:ok, comment4} =
  Contents.create_comment(%{post_id: post2.id, user_id: post2.id, message: "I love StarWars"})

{:ok, _} =
  Contents.create_comment(%{
    post_id: post1.id,
    comment_id: comment1.id,
    user_id: post2.id,
    message: "hahahah"
  })

{:ok, _} =
  Contents.create_comment(%{
    post_id: post2.id,
    comment_id: comment4.id,
    user_id: post2.id,
    message: "I too"
  })

{:ok, reply2} =
  Contents.create_comment(%{
    post_id: post2.id,
    comment_id: comment3.id,
    message: "No, I don't understand",
    user_id: user1.id
  })

{:ok, _} =
  Contents.create_comment(%{
    post_id: post2.id,
    comment_id: comment3.id,
    message: "I don't agree",
    user_id: post2.id
  })

{:ok, _} =
  Contents.create_comment(%{
    post_id: post1.id,
    comment_id: comment1.id,
    user_id: user1.id,
    message: "Thanks you"
  })

{:ok, _} =
  Contents.create_comment(%{
    post_id: post2.id,
    comment_id: reply2.id,
    user_id: post2.id,
    message: "Finished"
  })
