# a flag parsing single file lib for odin
this is meant to be a simple alternative for [odin's flag parser](https://pkg.odin-lang.org/core/flags/)

## how to install
### in same directory
simply copy the file in your project directory and rename the package to your own

### in a separate
add this to a new subdirectory ("dir/flag/flag.odin" for example)
and import it from that dir (import "./dir/flag")

NOTE: if you do that you will have to refer to the function using the namespace

example: add_flag() -> flag.add_flags()

## usage
[example.odin](https://github.com/PigeonCoding/flag.odin/blob/master/example.odin) 
```odin
  add_flag("name", "", "give your name")
  add_flag("age", 0, "give your age")
  add_flag("single", false, "are you single?")

  fl, remaining := check_flags()

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

  print_usage()

```
```console
$ odin build . -out:example
$ ./example -age 69 -name pigeon -single
```
