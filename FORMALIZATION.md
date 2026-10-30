# Formalization

## Overview

This project formalizes results on order continuity of lattice homomorphisms
between free p-convex Banach lattices, and on order density and majorization
for the canonical inclusions between different exponents.

All **30 numbered results** of the paper's 20 October 2026 version are proved,
including the Hilbert-space example in Remark 5.4. All scalar fields are real,
and the exponent range includes infinity.

The development constructs the free spaces as spaces of positively homogeneous
functions on the continuous dual, proves their universal property, and connects
the construction at p = 1 to BanLat's free Banach lattice. The operator-extension
predicates `POEWith p E M C` and `HasPOE p E M` describe the ambient-space/subspace
pair explicitly and include closedness of `M` in `E`.

## Dependencies

| Component | Pinned version |
| --- | --- |
| Lean | `leanprover/lean4:v4.35.0` |
| Mathlib | v4.35.0, commit `56a005855ea17e0b0958f73ec801ae140b0a1679` |
| BanLat | Commit `33c4b73fce845c4295614326193d4e52111be762` |

[lean-toolchain](lean-toolchain) selects Lean;
[lakefile.toml](lakefile.toml) pins BanLat;
[lake-manifest.json](lake-manifest.json) locks Mathlib and the transitive dependencies.

## Build and verification

With Lean installed through elan, run the following commands from the repository root:

```bash
lake exe cache get
lake build
lake env lean scripts/Audit.lean
```

The cache command retrieves precompiled Mathlib dependencies. The audit is run
separately from the library build.

Verification of these Lean sources on **30 October 2026** established:

- The full library builds without warnings or errors.
- All **1,274 project declarations**, including private and generated helpers,
  pass the transitive axiom audit in [scripts/Audit.lean](scripts/Audit.lean).
- The only axioms used are `propext`, `Classical.choice`, and `Quot.sound`.
- No proof placeholders or custom axioms remain.

## Modules

| Module | Contents |
| --- | --- |
| [Model](FBLOrderContinuousLH/Model.lean) | Constructs the free spaces, their norms, universal property, and induced operators, with a bridge to BanLat. |
| [Order](FBLOrderContinuousLH/Order.lean) | Proves criteria using sequences, separable reduction, algebraic free-lattice results, and the endpoint order-continuity characterization. |
| [Support](FBLOrderContinuousLH/Support.lean) | Develops p-compact disks, support seminorms, local control, approximation, positive patches, and finite-support majorants. |
| [LpExtension](FBLOrderContinuousLH/LpExtension.lean) | Proves the finite-dimensional ell-p extension lemma through a tensor gauge and Hahn–Banach extension. |
| [Extension](FBLOrderContinuousLH/Extension.lean) | Proves the POE characterization and its consequences for closed subspaces, biduals, C(K), c0, and separable injectivity. |
| [ParameterWitness](FBLOrderContinuousLH/ParameterWitness.lean) | Constructs compact-support witnesses and decreasing sequences detecting failure of order continuity between exponents. |
| [HilbertComparison](FBLOrderContinuousLH/HilbertComparison.lean) | Proves the comparison of the p = 1 and p = 2 free norms over Hilbert spaces. |
| [EuclideanFamilies](FBLOrderContinuousLH/EuclideanFamilies.lean) | Constructs finite dual families with controlled weak Euclidean norm and individual norms bounded below. |
| [ConvexityBound](FBLOrderContinuousLH/ConvexityBound.lean) | Establishes free-norm growth estimates and the obstruction to stronger convexity exponents. |
| [Parameters](FBLOrderContinuousLH/Parameters.lean) | Proves the equivalence of eight conditions for inclusions between exponents, compact witnesses, and the q > 2 and Hilbert-space consequences. |

The main import chain, which also gives a reading order, is:

```text
Model → Order → Support → Extension → ParameterWitness
      → HilbertComparison → EuclideanFamilies → ConvexityBound → Parameters
```

There is an additional branch `Model → LpExtension → Extension`.
Importing [FBLOrderContinuousLH](FBLOrderContinuousLH.lean) loads the entire library.

## Paper correspondence

Numbering follows the paper's 20 October 2026 version. Every entry is proved.
All declaration names belong to the namespace `FBLOrderContinuousLH`.

| Paper result | Lean declaration | Source |
| --- | --- | --- |
| Theorem 1.1 | `intro_infty` | [Order.lean:1804](FBLOrderContinuousLH/Order.lean#L1804) |
| Proposition 1.2 | `necessary` | [Order.lean:1470](FBLOrderContinuousLH/Order.lean#L1470) |
| Theorem 1.3 | `intro_poe` | [Extension.lean:735](FBLOrderContinuousLH/Extension.lean#L735) |
| Lemma 2.1 | `csp` | [Order.lean:453](FBLOrderContinuousLH/Order.lean#L453) |
| Proposition 2.2 | `csp_operator` | [Order.lean:92](FBLOrderContinuousLH/Order.lean#L92) |
| Lemma 2.3 | `sigma_order_continuity` | [Order.lean:494](FBLOrderContinuousLH/Order.lean#L494) |
| Proposition 2.4 | `fvl_sequential_test` | [Order.lean:600](FBLOrderContinuousLH/Order.lean#L600) |
| Lemma 2.5 | `separable_reduction` | [Order.lean:1073](FBLOrderContinuousLH/Order.lean#L1073) |
| Lemma 2.6 | `regular_inclusion` | [Order.lean:1964](FBLOrderContinuousLH/Order.lean#L1964) |
| Theorem 2.7 | `fvl_characterization` | [Order.lean:1971](FBLOrderContinuousLH/Order.lean#L1971) |
| Proposition 3.1 | `injectivity` | [Order.lean:1270](FBLOrderContinuousLH/Order.lean#L1270) |
| Proposition 3.2 | `noncompact_minima` | [Order.lean:1408](FBLOrderContinuousLH/Order.lean#L1408) |
| Corollary 3.3 | `c0` | [Extension.lean:1312](FBLOrderContinuousLH/Extension.lean#L1312) |
| Theorem 4.1 | `poe_inclusion` | [Extension.lean:537](FBLOrderContinuousLH/Extension.lean#L537) |
| Lemma 4.2 | `majorant_norm` | [Support.lean:823](FBLOrderContinuousLH/Support.lean#L823) |
| Lemma 4.3 | `summable_local_control` | [Support.lean:1858](FBLOrderContinuousLH/Support.lean#L1858) |
| Corollary 4.4 | `summable_approximation` | [Support.lean:1902](FBLOrderContinuousLH/Support.lean#L1902) |
| Corollary 4.5 | `summable_global_domination` | [Support.lean:1960](FBLOrderContinuousLH/Support.lean#L1960) |
| Proposition 4.6 | `positive_patches` | [Support.lean:2090](FBLOrderContinuousLH/Support.lean#L2090) |
| Lemma 4.7 | `subsets_summable_disk` | [Support.lean:2378](FBLOrderContinuousLH/Support.lean#L2378) |
| Lemma 4.8 | `restriction_polar` | [Support.lean:2562](FBLOrderContinuousLH/Support.lean#L2562) |
| Proposition 4.9 | `poe_sufficiency` | [Extension.lean:258](FBLOrderContinuousLH/Extension.lean#L258) |
| Lemma 4.10 | `finite_support_majorant` | [Support.lean:2724](FBLOrderContinuousLH/Support.lean#L2724) |
| Lemma 4.11 | `compact_support_order_null` | [Support.lean:2899](FBLOrderContinuousLH/Support.lean#L2899) |
| Proposition 4.12 | `poe_necessity` | [Extension.lean:429](FBLOrderContinuousLH/Extension.lean#L429) |
| Corollary 4.13 | `bidual_order_continuity` | [Extension.lean:992](FBLOrderContinuousLH/Extension.lean#L992) |
| Theorem 5.1 | `cross_parameter_inclusion` | [Parameters.lean:157](FBLOrderContinuousLH/Parameters.lean#L157) |
| Proposition 5.2 | `cross_parameter_witness` | [Parameters.lean:78](FBLOrderContinuousLH/Parameters.lean#L78) |
| Corollary 5.3 | `cross_parameter_above_two` | [Parameters.lean:449](FBLOrderContinuousLH/Parameters.lean#L449) |
| Remark 5.4 | `cross_parameter_hilbert` | [Parameters.lean:484](FBLOrderContinuousLH/Parameters.lean#L484) |
