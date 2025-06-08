package flag

import "core:fmt"

main :: proc() {

  add_flag("name", "", "give your name")
  add_flag("age", 0, "give your age")
  add_flag("single", false, "are you single?")

  fl, remaining := check_flags()

  fmt.println("-----------------")
  for l in fl {
    switch l.flag {
    case "name":
      fmt.println("your name is", l.value)
    case "age":
      fmt.println("your age is", l.value)
    case "single":
      fmt.println("you are single")
    }
  }

  fmt.println("-----------------")
  fmt.println("remaining args:", remaining)
  fmt.println("-----------------")

  print_usage()
  fmt.println("-----------------")

}
