package flag

import "core:fmt"
import "core:os"

main :: proc() {

  f_container: flag_container

  add_flag(&f_container, "name", "", "give your name") // string
  add_flag(&f_container, "age", 0, "give your age") // int
  add_flag(&f_container, "single", false, "are you single?") // bool

  
  if len(os.args) == 1 {
    fmt.println("usage", os.args[0])
    print_usage(&f_container)
    os.exit(1)
  }
  
  check_flags(&f_container)
  fmt.println("-----------------")
  for l in f_container.parsed_flags {
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
  fmt.println("remaining args:", f_container.remaining)
  fmt.println("-----------------")

  free_flag_container(&f_container)
}
