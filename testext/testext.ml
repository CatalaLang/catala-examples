(* This is a template file following the expected interface and declarations to
 * implement the corresponding Catala module.
 *
 * You should replace all `raise (Error (Impossible))` place-holders with your
 * implementation and rename it to remove the ".template" suffix. *)

let test_yojson () =
  let json_string = {|
  {"number" : 42,
   "string" : "yes",
   "list": ["for", "sure", 42]}|}
  in
  let json = Yojson.Safe.from_string json_string
  in
  Format.eprintf "Parsed to %a@\n" Yojson.Safe.pp json

let test_sqlite3 () =
  let open Sqlite3_utils in
  with_db ":memory:" (fun db ->
      exec0_exn db "create table person (name text, age int);";
      exec0_exn db "insert into person values ('alice', 20), ('bob', 25) ;";
      exec_raw_args db "select age from person where name=? ;" [| Data.TEXT "alice" |]
        ~f:Cursor.to_list)
  |> function
  | Ok [[|Sqlite3_utils.Data.INT n|]] -> Format.eprintf "SQLITE3 => %Ld\n" n
  | Error _ -> Format.eprintf "SQLITE3 => ERROR\n"
  | _ -> Format.eprintf "SQLITE3 => ???\n"

[@@@ocaml.warning "-4-26-27-32-33-34-37-41-42-69"]

open Catala_runtime


module Stdlib_en
  = Stdlib_en
module Date_en = Date_en
module List_en = List_en
module Duration_en = Duration_en
module MonthYear_en = MonthYear_en
module Period_en = Period_en
module Money_en = Money_en
module Integer_en = Integer_en
module Decimal_en = Decimal_en


(* Toplevel def fun *)
let fun__1 : integer -> integer =
  fun (_: integer) ->
  test_yojson ();
  test_sqlite3 ();
  Z.zero

let () =
  Catala_runtime.register_module "Testext"
    [ "fun", Stdlib.Obj.repr (fun__1) ]
    ~types:[]
    "*external*"
