package flag

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

flag_val_types :: union {
  int,
  string,
  bool,
}
flag_t :: struct {
  flag:        string,
  value:       flag_val_types,
  description: string,
}
flag_list: [dynamic]flag_t

add_flag :: proc(flag_name: string, initial_val: flag_val_types, description: string) {
  t: flag_t
  t.flag = flag_name
  t.value = initial_val
  t.description = description

  append(&flag_list, t)
}
// execute that before any kind of check on args, it will return any unused args for you to handle
// including program name
check_flags :: proc() -> (found: []^flag_t, remaining_args: []string) {
  // let the user delete it when they feel like it
  ff: [dynamic]^flag_t
  // TODO: maybe find a better way?
  rem: [dynamic]string

  arg_i := 0
  for arg_i < len(os.args) {

    if os.args[arg_i] == "---" {
      break
    }

    if strings.starts_with(os.args[arg_i], "-") {
      for &f in flag_list {
        if os.args[arg_i][1:] == f.flag {
          yes := false
          switch v in f.value {
          case bool:
            // fmt.println("yes")
            yes = true
          case int:
            arg_i += 1
            if os.args[arg_i][0] == '-' || (os.args[arg_i][0] >= '0' && os.args[arg_i][0] <= '9') {
              f.value = strconv.atoi(os.args[arg_i])
              yes = true
            }
          case string:
            arg_i += 1
            yes = true
            f.value = os.args[arg_i]
          }

          if yes do append(&ff, &f)

        }
      }
    } else {
      append(&rem, os.args[arg_i])
    }
    arg_i += 1
  }

  for i in arg_i ..< len(os.args) {
    append(&rem, os.args[i])
  }

  return ff[:], rem[:]
}
print_usage :: proc() {
  max_len := 0

  for f in flag_list {
    if len(f.flag) > max_len {
      max_len = len(f.flag)
    }
  }

  for f in flag_list {
    t: string
    switch v in f.value {
    case int:
      t = "(int)   :"
    case bool:
      t = "(bool)  :"
    case string:
      t = "(string):"
    }

    fmt.printfln("%*.s%s {}", max_len, f.flag, t, f.description)
  }
}
