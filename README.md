# a flag parsing single file lib for odin
this is meant to be a simple alternative to [odin's flag parser](https://pkg.odin-lang.org/core/flags/)

## how to install
### in same directory
simply copy the file in your project directory and rename the package to your own

### in a separate directory
add this to a new subdirectory ("dir/flag/flag.odin" for example)
and import it from that dir (import "./dir/flag")

NOTE: if you do that you will have to refer to the function using the namespace

example: add_flag() -> flag.add_flags()

## usage
[example.odin](https://github.com/PigeonCoding/flag.odin/blob/master/example.odin) 
```odin
  f_container: flag_container

  add_flag(&f_container, "name", "", "give your name") // string
  add_flag(&f_container, "age", 0, "give your age") // int
  add_flag(&f_container, "single", false, "are you single?") // bool

  if len(os.args) == 1 {
    fmt.println("usage", os.args[0])
    print_usage(&f_container)
    os.exit(1)
  }

  init_container(&f_container)
  check_flags(&f_container)

  name: ^string = auto_cast get_flag_value(&f_container, "name")
  age: ^int = auto_cast get_flag_value(&f_container, "age")
  single: ^bool = auto_cast get_flag_value(&f_container, "single")
  
  if name != nil do fmt.println("your name is", name^)
  if age != nil do fmt.println("your age is", age^)
  if single != nil do fmt.println("you are single")


  fmt.println("remaining args:", f_container.remaining)

  free_flag_container(&f_container)
```
```console
$ odin run . -- -name pigeon -age 69 -single
```
