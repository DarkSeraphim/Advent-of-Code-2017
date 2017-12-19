let rec parse_input pipe_groups =
  let line = read_line () in
    if line = "end-of-input"
      then pipe_groups
    else
      let s = Str.split (Str.regexp " <-> ") line in
      let l = Str.split (Str.regexp ", ") (List.nth s 1) in
      let l' = (List.nth s 0) :: l in
      let connected = List.map (fun x -> (int_of_string x)) l' in
      let (yes, no) = List.partition (fun x -> List.exists (fun y -> List.mem y connected) x) pipe_groups in
        parse_input (List.flatten (connected :: yes) :: no)
;;
let pipe_groups = parse_input [] ;;
print_endline (Printf.sprintf ("Amount of groups: %d") (List.length pipe_groups)) ;;
