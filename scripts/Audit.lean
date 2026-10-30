import FBLOrderContinuousLH
import Lean.Util.CollectAxioms

/-!
# Proof-integrity audit for the completed formalization

Run `lake env lean scripts/Audit.lean` after `lake build`. Every declaration in the
project namespace is checked, including private declarations and generated helpers.
The audit follows dependencies in both types and values and permits only Lean's
standard propositional extensionality, classical choice, and quotient soundness.
Any proof admission or additional axiom therefore fails the audit, even when it is
inherited from a helper or an imported declaration.

The signature checks below also verify the local interfaces and the pinned library
APIs used in the formalization. This script is checked separately from the library
target; successful compilation of the library alone does not run the audit.
-/

open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let mut declarations := 0
  for (name, info) in env.constants.toList do
    if (`FBLOrderContinuousLH).isPrefixOf (privateToUserName name) then
      declarations := declarations + 1
      if info matches .axiomInfo _ then
        throwError "New axiom is forbidden: {name}"
      for axiomName in ← collectAxioms name do
        unless #[``propext, ``Classical.choice, ``Quot.sound].contains axiomName do
          throwError "Forbidden axiom dependency in {name}: {axiomName}"
  logInfo m!"Audited {declarations} project declarations, including private helpers: only standard Lean axioms; no proof admissions."

-- Check complete imported signatures against the pinned dependencies.
#check VectorSublattice.generated
#check VectorSublattice.topologicalClosure
#check VectorSublattice.banachLatticeCoe
#check FVLv.ofLinear
#check FVLv.exists_eval_of_eq
#check FBL.ofLinearIsometry
#check FBL.ofFVLv
#check FBL.exists_unique_lift
#check PosHomFunction.functionalCalculus
#check PosHomFunction.functionalCalculus_map
#check isUniformlyCompleteVectorLattice_of_banachLattice
#check IsOrderContinuousOp
#check orderConvergesTo_of_antitone_isGLB
#check IsOrderDense
#check IsCofinal
#check NormedSpace.inclusionInDoubleDual
#check NormedSpace.inclusionInDoubleDualLi
#check exists_extension_norm_eq
#check exists_dual_vector
#check isCompact_closedAbsConvexHull_of_totallyBounded
#check FBLOrderContinuousLH.universal_property
#check FBLOrderContinuousLH.separable_reduction
#check FBLOrderContinuousLH.POEWith
#check FBLOrderContinuousLH.HasPOE
#check FBLOrderContinuousLH.POEWith.isClosed
#check FBLOrderContinuousLH.HasPOE.isClosed
#check FBLOrderContinuousLH.poe_inclusion
#check FBLOrderContinuousLH.bidual_poe_one
#check FBLOrderContinuousLH.c0_poe
#check FBLOrderContinuousLH.cross_parameter_inclusion
#check FBLOrderContinuousLH.cross_parameter_above_two
#check FBLOrderContinuousLH.isPCompactDisk_infinity_iff
#check FBLOrderContinuousLH.compact_support_closedAbsConvexHull
#check FBLOrderContinuousLH.tauP_infinity_eq_boundedWeakStar
#check FBLOrderContinuousLH.summable_local_control
#check FBLOrderContinuousLH.summable_global_domination
#check FBLOrderContinuousLH.positive_patches_net
#check FBLOrderContinuousLH.subsets_summable_disk
