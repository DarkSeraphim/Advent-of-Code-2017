package main

import (
    "fmt"
)

func main() {
  var state [16]int
  var seen = make(map[string]bool)
  parseArray(state[:])
  var mutations = 0
  fmt.Println(toString(state[:]))
  fmt.Println()
  for add(seen, state[:]) {
    var index, value = max(state[:])
    state[index] = 0
    var div = value / 16
    var mod = value % 16
    for i, v := range state {
      var x = (i - index - 1 + 16) % 16
      v += div
      if x < mod {
        v++
      }
      state[i] = v
    }
    mutations++
  }
  fmt.Printf("Found a cycle after %d mutations.\n", mutations)
}

func parseArray(state []int) {
  for i, _ := range state {
    _, err := fmt.Scanf("%d", &state[i])
    if err != nil {
      fmt.Println("Err!")
    }
  }
}

func add(set map[string]bool, key []int) bool {
  var sk = toString(key)
  if set[sk] {
    return false
  }
  set[sk] = true
  return true
}

func toString(array []int) string {
  var str = ""
  for i, v := range array {
    if i > 0 {
      str += ","
    }
    str += fmt.Sprint(v)
  }
  return str
}

func max(array []int) (int, int) {
  var value = -1
  var index = -1
  for i, v := range array {
    if value < v {
      value = v
      index = i
    }
  }
  return index, value
}
