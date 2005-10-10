(***********************************************************************)
(*                                                                     *)
(*                    ______________                                   *)
(*                                                                     *)
(*      Fabrice Le Fessant, projet SOR/PARA INRIA Rocquencourt         *)
(*      Luc Maranget, projet Moscova                                   *)
(*                                                                     *)
(*  Copyright 2005 Institut National de Recherche en Informatique et   *)
(*  Automatique.  Distributed only by permission.                      *)
(*                                                                     *)
(*                                                                     *)
(***********************************************************************)

(* $Id$ *)

(* Forward pointers for local message sending, set by module Join *)
type async_ref =
  { mutable async : 'a . Join_types.automaton -> int -> 'a -> unit }
val send_async_ref : async_ref

type sync_ref =
    { mutable sync : 'a 'b . Join_types.automaton -> int -> 'a -> 'b}
val send_sync_ref : sync_ref

(* Function exn_global loc exn_cstr
   registers the exception constructor exn_cstr as a global one.

   It fails if a structurally equivalent constructor have
   already been globalized, loc is a position in source file for
   error message *)
val exn_global : (string * int * int) -> Obj.t -> unit

(* Specialized input_value/output_value for parameters *)
val read_parameter : in_channel -> Join_types.parameter
val write_parameter : out_channel -> Join_types.parameter -> unit

(* Change a value to parameter and back *)
val globalize :
    'a ->  Marshal.extern_flags list -> Join_types.parameter
val localize : Join_types.parameter -> 'a

val remote_send_async :
    Join_types.space_id ->
      int (* uid *) -> int (* channnel *) -> 'a (* message *) -> unit

val remote_send_alone :
    Join_types.space_id ->
      int (* uid *) -> 'a (* message *) -> unit

val remote_send_sync :
    Join_types.space_id ->
      int (* uid *) -> int (* channnel *) -> Join_types.continuation ->
	'a (* message *) -> 'b

val remote_send_sync_alone :
    Join_types.space_id ->
      int (* uid *) -> Join_types.continuation ->
	'a (* message *) -> 'b

val halt : unit -> unit

val flush_space : unit -> unit
