Require Import Monad.

Set Implicit Arguments.

Definition M := State.t bool.

Definition incr (n : nat) : M nat :=
  ret (n + 1).

Definition twelve : M nat :=
  ret 12.

Monadic f := (incr (incr twelve)).
Print f.


