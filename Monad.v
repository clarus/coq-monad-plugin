Declare ML Module "monadPlugin".

Set Implicit Arguments.

Class Monad (t : Type -> Type) : Type := {
  ret : forall A, A -> t A;
  bind : forall A B, t A -> (A -> t B) -> t B}.

Module State.
  Definition t (S : Type) : Type -> Type :=
    fun A => S -> A * S.
  
  Instance Monad (S : Type) : Monad (t S) := {
    ret := fun _ x =>
      fun s => (x, s);
    bind := fun _ _ x f =>
      fun s =>
        let (x', s') := x s in
        f x' s'}.
End State.

